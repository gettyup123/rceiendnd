<!DOCTYPE html>
 
 
 
<html>
 
 
 
  <head>
 
 
 
    <title>Race it off</title>
 
 
 
    <style>
 
      #container {
 
 
 
        width: 100%;
 
 
 
        height: 400px;
 
 
 
        position: relative;
 
 
 
        border: 1px solid #000;
 
 
 
        overflow: hidden;
 
 
 
        background-color: #666;
 
 
 
      }
 
 
 
 
      /* Add a white line in the middle of the road */
 
 
 
      #container::before {
 
 
 
        content: "";
 
 
 
        width: 10px;
 
 
 
        height: 100%;
 
 
 
        background-color: white;
 
 
 
        position: absolute;
 
 
 
        left: 50%;
 
 
 
        transform: translateX(-50%);
 
 
 
      }
 
 
 
 
      #car {
 
 
 
        width: 50px;
 
 
 
        height: 80px;
 
 
 
        position: absolute;
 
 
 
        bottom: 10px;
 
 
 
        left: 50%;
 
 
 
        transform: translateX(-50%);
 
 
 
        background-color: purple;
 
 
 
        border-radius: 10px;
 
 
 
        overflow: hidden;
 
 
 
      }
 
 
 
 
      #car .window {
 
 
 
        width: 30px;
 
 
 
        height: 55px;
 
 
 
        position: absolute;
 
 
 
        top: 15px;
 
 
 
        left: 50%;
 
 
 
        transform: translateX(-50%);
 
 
 
        background-color: lightblue;
 
 
 
        border-radius: 5px;
 
 
 
      }
 
 
 
 
      /* Four separate stripes at the corners of the car */
 
 
 
      #car .stripe {
 
 
 
        width: 6px;
 
 
 
        height: 20px;
 
 
 
        position: absolute;
 
 
 
        background-color: black;
 
 
 
      }
 
 
 
 
      #car .stripe.top-left {
 
 
 
        top: 10px;
 
 
 
        left: 0;
 
 
 
      }
 
 
 
 
      #car .stripe.top-right {
 
 
 
        top: 10px;
 
 
 
        right: 0;
 
 
 
      }
 
 
 
 
      #car .stripe.bottom-left {
 
 
 
        bottom: 10px;
 
 
 
        left: 0;
 
 
 
      }
 
 
 
 
      #car .stripe.bottom-right {
 
 
 
        bottom: 10px;
 
 
 
        right: 0;
 
 
 
      }
 
 
 
 
      /* Tree classes */
 
 
 
      .obstacle.tree {
 
 
 
        position: absolute;
 
 
 
      }
 
 
 
 
      .obstacle.tree.standing {
 
 
 
        background-color: brown;
 
 
 
        width: 20px;
 
 
 
        height: 100px;
 
 
 
        border-radius: 5px;
 
 
 
      }
 
 
 
 
      .obstacle.tree.flat {
 
 
 
        width: 100px;
 
 
 
        height: 20px;
 
 
 
        position: absolute;
 
 
 
        background-color: green;
 
 
 
        border: 1px solid #006400;
 
        /* Green border for flat trees */
 
 
 
        border-radius: 5px;
 
        /* Rounded corners for flat trees */
 
 
 
      }
 
 
 
 
      /* Traffic cone class */
 
 
 
      .obstacle.cone {
 
 
 
        width: 20px;
 
 
 
        height: 40px;
 
 
 
        position: absolute;
 
 
 
        background-color: orange;
 
 
 
        border-bottom: 8px solid black;
 
 
 
        border-radius: 5px;
 
 
 
      }
 
 
 
 
      #score {
 
 
 
        position: absolute;
 
 
 
        bottom: 10px;
 
 
 
        left: 10px;
 
 
 
        font-size: 18px;
 
 
 
        color: dark grey;
 
 
 
      }
 
 
 
 
      /* Game over overlay */
 
 
 
      #game-over-overlay {
 
 
 
        width: 100%;
 
 
 
        height: 100%;
 
 
 
        position: absolute;
 
 
 
        top: 0;
 
 
 
        left: 0;
 
 
 
        background-color: rgba(0, 0, 0, 0.7);
 
 
 
        display: none;
 
 
 
        justify-content: center;
 
 
 
        align-items: center;
 
 
 
      }
 
 
 
 
      #game-over-text {
 
 
 
        color: white;
 
 
 
        font-size: 36px;
 
 
 
      }
 
 
    </style>
 
 
 
  </head>
 
 
 
  <body>
 
 
 
    <h1>Race it off</h1>
 
 
 
    <div id="container">
 
 
 
      <div id="car">
 
 
 
        <div class="window"></div>
 
 
 
        <div class="stripe top-left"></div>
 
 
 
        <div class="stripe top-right"></div>
 
 
 
        <div class="stripe bottom-left"></div>
 
 
 
        <div class="stripe bottom-right"></div>
 
 
 
      </div>
 
 
 
    </div>
 
    <audio id="carSound" preload="auto">
 
      <!-- Add the source for the "New_Project.m4a" audio file here -->
 
      <source src="New_Project.m4a" type="audio/mp4">
 
      Your browser does not support the audio element.
 
    </audio>
 
 
 
    <div id="score">Score: 0</div>
 
 
 
    <div id="game-over-overlay">
 
 
 
      <div id="game-over-text">Game Over</div>
 
 
 
    </div>
 
 
 
    <script>
 
      const car = document.getElementById('car');
 
 
 
      let carPosition = 50;
 
 
 
      let carSpeed = 0;
 
 
 
      let targetSpeed = 0;
 
 
 
      let score = 0;
 
 
 
      let isPaused = false;
 
 
 
      let treeSpeed = 3;
 
 
 
 
      document.addEventListener('keydown', (event) => {
 
 
 
        if (event.key === 'ArrowLeft') {
 
 
 
          targetSpeed = -5;
 
 
 
        } else if (event.key === 'ArrowRight') {
 
 
 
          targetSpeed = 5;
 
 
 
        } else if (event.key === ' ') {
 
 
 
          isPaused = !isPaused;
 
 
 
          if (isPaused) {
 
 
 
            clearInterval(obstacleInterval);
 
 
 
            clearInterval(trafficConeInterval);
 
 
 
            clearInterval(moveInterval);
 
 
 
          } else {
 
 
 
            obstacleInterval = setInterval(createObstacle, 1000);
 
 
 
            trafficConeInterval = setInterval(createTrafficCone, 3000);
 
 
 
            moveInterval = setInterval(moveObstacles, 30);
 
 
 
          }
 
 
 
        }
 
 
 
      });
 
 
 
 
      document.addEventListener('keyup', (event) => {
 
 
 
        if (event.key === 'ArrowLeft' || event.key === 'ArrowRight') {
 
 
 
          targetSpeed = 0;
 
 
 
        }
 
 
 
      });
 
 
 
 
      const container = document.getElementById('container');
 
 
 
      const obstacles = [];
 
 
 
 
      function createObstacle() {
 
 
 
        const obstacle = document.createElement('div');
 
 
 
        obstacle.className = 'obstacle tree';
 
 
 
 
        if (Math.random() < 0.3) {
 
 
 
          obstacle.classList.add('standing');
 
 
 
          obstacle.style.width = '20px'; // Set the width to match the standing tree
 
 
 
          obstacle.style.height = '100px'; // Set the height to match the standing tree
 
 
 
        } else {
 
 
 
          obstacle.classList.add('flat');
 
 
 
          obstacle.style.width = '100px'; // Set the width to match the flat tree
 
 
 
          obstacle.style.height = '20px'; // Set the height to match the flat tree
 
 
 
        }
 
 
 
 
        obstacle.style.left = Math.random() * (container.clientWidth - parseInt(obstacle.style.width)) + 'px';
 
 
 
        container.appendChild(obstacle);
 
 
 
        obstacles.push(obstacle);
 
 
 
      }
 
 
 
 
      function createTrafficCone() {
 
 
 
        const cone = document.createElement('div');
 
 
 
        cone.className = 'obstacle cone';
 
 
 
        cone.style.width = '20px'; // Set the width to match the traffic cone
 
 
 
        cone.style.height = '40px'; // Set the height to match the traffic cone
 
 
 
        cone.style.left = Math.random() * (container.clientWidth - parseInt(cone.style.width)) + 'px';
 
 
 
        container.appendChild(cone);
 
 
 
        obstacles.push(cone);
 
 
 
      }
 
 
 
 
      function moveObstacles() {
 
 
 
        for (let i = 0; i < obstacles.length; i++) {
 
 
 
          const obstacle = obstacles[i];
 
 
 
          const obstaclePosition = parseInt(obstacle.style.top) || 0;
 
 
 
          obstacle.style.top = obstaclePosition + treeSpeed + 'px';
 
 
 
 
          if (obstaclePosition > container.clientHeight) {
 
 
 
            container.removeChild(obstacle);
 
 
 
            obstacles.splice(i, 1);
 
 
 
            score += 10;
 
 
 
            document.getElementById('score').textContent = 'Score: ' + score;
 
 
 
 
            if (score % 50 === 0) {
 
 
 
              carSpeed += 2;
 
 
 
              treeSpeed += 1;
 
 
 
            }
 
 
 
          }
 
 
 
 
          if (
 
 
 
            carPosition + 50 > parseInt(obstacle.style.left) &&
 
 
 
            carPosition < parseInt(obstacle.style.left) + parseInt(obstacle.style.width) &&
 
 
 
            container.clientHeight - 10 - 80 < obstaclePosition + parseInt(obstacle.style.height)
 
 
 
          ) {
 
 
 
            endGame();
 
 
 
          }
 
 
 
 
          if (
 
 
 
            obstacle.classList.contains('flat') &&
 
 
 
            carPosition + 50 > parseInt(obstacle.style.left) &&
 
 
 
            carPosition < parseInt(obstacle.style.left) + parseInt(obstacle.style.width) &&
 
 
 
            container.clientHeight - 10 - 80 < obstaclePosition + 20
 
 
 
          ) {
 
 
 
            endGame();
 
 
 
          }
 
 
 
        }
 
 
 
      }
 
 
 
 
      function endGame() {
 
 
 
        clearInterval(obstacleInterval);
 
 
 
        clearInterval(trafficConeInterval);
 
 
 
        clearInterval(moveInterval);
 
 
 
        document.removeEventListener('keydown', handleKeyPress);
 
 
 
 
        const gameOverOverlay = document.getElementById('game-over-overlay');
 
 
 
        const gameOverText = document.getElementById('game-over-text');
 
 
 
        gameOverText.textContent = 'Game Over\nScore: ' + score;
 
 
 
        gameOverOverlay.style.display = 'flex';
 
 
 
      }
 
 
 
 
      let obstacleInterval = setInterval(createObstacle, 1000);
 
 
 
      let trafficConeInterval = setInterval(createTrafficCone, 3000);
 
 
 
      let moveInterval = setInterval(moveObstacles, 30);
 
 
 
 
      function updateCarPosition() {
 
 
 
        if (!isPaused) {
 
 
 
          if (carSpeed < targetSpeed) {
 
 
 
            carSpeed += 0.2;
 
 
 
          } else if (carSpeed > targetSpeed) {
 
 
 
            carSpeed -= 0.2;
 
 
 
          }
 
 
 
 
          carPosition += carSpeed;
 
 
 
          carPosition = Math.max(0, Math.min(container.clientWidth - 50, carPosition));
 
 
 
          car.style.left = carPosition + 'px';
 
 
 
        }
 
 
 
 
        requestAnimationFrame(updateCarPosition);
 
 
 
      }
 
 
 
 
      updateCarPosition();
 
 
    </script>
 
 
 
  </body>
 
<audio id="background-music" autoplay loop>
 
  <source src="https://upload.wikimedia.org/wikipedia/commons/6/62/A_4_second_beat.ogg" type="audio/ogg">
 
  Your browser does not support the audio element.
 
</audio>
 
 
<script>
 
  const backgroundMusic = document.getElementById('background-music');
 
  let isPlaying = true;
 
 
  document.addEventListener('keydown', (event) => {
 
    if (event.key === ' ') {
 
      if (isPlaying) {
 
        backgroundMusic.pause();
 
      } else {
 
        backgroundMusic.play();
 
      }
 
      isPlaying = !isPlaying;
 
    }
 
  });
 
</script>
 
 
 
 
 
 
</html>
