// Select the button and output paragraph
const button = document.getElementById('action-button');
const output = document.getElementById('output');

// Add a click event listener to the button
button.addEventListener('click', () => {
    output.textContent = "Hello! You've clicked the button.";
    output.style.color = "#4CAF50";
});