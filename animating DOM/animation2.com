<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Animating styles with requestAnimationFrame</title>
    </head>
    <body>
    <div>
        <img id="ohnoes" src="cry.png">
        <h1>Oh no,We are going to die in
            <span id="countdown">30</span>
            seconds!
        </h1>
        <div id="info"></div>
    </div>
    
  <script>
  var infoDiv = document.getElementById("info");
  
  var countdown = document.getElementById("countdown");
  var countItDown = function() {
    var currentTime = parseFloat(countdown.textContent);
    if (currentTime > 0) {
       countdown.textContent = currentTime - 1;   
    } else {
        window.clearInterval(timer);
    }
    
  };
  var timer = window.setInterval(countItDown, 1000);
  
  // Step 1. What element do we want to animate?
  var ohnoes = document.getElementById("ohnoes");
  ohnoes.style.width = "50px";
  
  // Step 2. What function will change it each time?
  var startTime = new Date().getTime();
  var makeItBigger = function() {
      var currTime = new Date().getTime();
      var newWidth = (50 + ((currTime - startTime)/1000) * 30);
       ohnoes.style.width = newWidth + "px"; 
       
       if (newWidth < 300) {
           window.requestAnimationFrame(makeItBigger);
       }
    
  };
  makeItBigger();
  </script>

    </body>
</html>