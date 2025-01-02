window.addEventListener("message", function (event) {
  const data = event.data;

  if (data.action === "start") {
      const prorgres = document.getElementById("prorgres");
      const procente = document.getElementById("procente");
      const progressText = document.getElementById("text");

      prorgres.style.display = "flex"; 
      progressText.innerHTML = data.txt;

      let progress = 0;
      const duration = data.s; 
      const startTime = performance.now(); 

      function animateProgress(currentTime) {
          const elapsed = currentTime - startTime; 
          progress = Math.min((elapsed / duration) * 100, 100); 
          
          prorgres.style.background = `conic-gradient(#FF3131 ${progress}%, #1a1a1a ${progress}%)`; 
          procente.innerHTML = `${Math.floor(progress)}%`; 

          if (progress < 100) {
              requestAnimationFrame(animateProgress); 
          }
      }

      requestAnimationFrame(animateProgress); 
  }

  if (data.action === "stop") {
      document.getElementById("prorgres").style.display = "none";
  }
});
