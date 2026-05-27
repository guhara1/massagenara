$ErrorActionPreference = "Stop"
$root = (Get-Location).Path
$prefix = "http://127.0.0.1:8080/"
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add($prefix)
$listener.Start()
Write-Host "Serving $root at $prefix"
while ($listener.IsListening) {
  $context = $listener.GetContext()
  try {
    $path = [Uri]::UnescapeDataString($context.Request.Url.AbsolutePath.TrimStart("/"))
    if ([string]::IsNullOrWhiteSpace($path)) { $path = "index.html" }
    $full = Join-Path $root $path
    if ((Test-Path $full -PathType Container)) { $full = Join-Path $full "index.html" }
    $resolved = [System.IO.Path]::GetFullPath($full)
    if (-not $resolved.StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase) -or -not (Test-Path $resolved -PathType Leaf)) {
      $context.Response.StatusCode = 404
      $bytes = [System.Text.Encoding]::UTF8.GetBytes("Not found")
    } else {
      $ext = [System.IO.Path]::GetExtension($resolved).ToLowerInvariant()
      $context.Response.ContentType = switch ($ext) {
        ".html" { "text/html; charset=utf-8" }
        ".css" { "text/css; charset=utf-8" }
        ".js" { "application/javascript; charset=utf-8" }
        ".svg" { "image/svg+xml" }
        ".xml" { "application/xml; charset=utf-8" }
        ".txt" { "text/plain; charset=utf-8" }
        ".webmanifest" { "application/manifest+json; charset=utf-8" }
        default { "application/octet-stream" }
      }
      $bytes = [System.IO.File]::ReadAllBytes($resolved)
    }
    $context.Response.ContentLength64 = $bytes.Length
    $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
  } catch {
    $context.Response.StatusCode = 500
  } finally {
    $context.Response.OutputStream.Close()
  }
}
