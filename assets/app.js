(function(){
  var toggle=document.querySelector('.nav-toggle'),menu=document.querySelector('.menu');
  if(toggle&&menu){toggle.addEventListener('click',function(){var open=toggle.getAttribute('aria-expanded')==='true';toggle.setAttribute('aria-expanded',String(!open));menu.classList.toggle('open',!open);});}
  var idle=window.requestIdleCallback||function(fn){setTimeout(fn,1)};
  idle(function(){if(!('IntersectionObserver'in window)){document.querySelectorAll('.reveal').forEach(function(e){e.classList.add('in')});return;}var io=new IntersectionObserver(function(es){es.forEach(function(e){if(e.isIntersecting){e.target.classList.add('in');io.unobserve(e.target);}})},{threshold:.12,rootMargin:'80px'});document.querySelectorAll('.reveal').forEach(function(el){io.observe(el)});});
})();