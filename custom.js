// Ensure the script runs after the page is fully loaded
window.onload = function () {
  // Select all table elements on the page
  const tables = document.querySelectorAll("table");

  // Loop through each table and wrap it with a div
  tables.forEach((table) => {
    const wrapper = document.createElement("div"); // Create a new div element
    wrapper.classList.add("table-wrapper"); // Optional: Add a class for styling

    // Insert the wrapper div before the table
    table.parentNode.insertBefore(wrapper, table);

    // Move the table inside the div
    wrapper.appendChild(table);
  });

  // Select the main element
  const mainElement = document.querySelector("main");
  const body = document.querySelector("body");
  // Select the cover-page-container
  const coverPageContainer = document.querySelector("#cover-page-container");
  const header = document.querySelector("header");

  // Prepend the cover page container to the main element
  if (body && mainElement && coverPageContainer) {
    body.prepend(header);
    mainElement.prepend(coverPageContainer);
  }
};

function addSmoothToggleButtons() {
  const classicCodeCells = document.querySelectorAll("div.code_cell");
  const labCodeCells = document.querySelectorAll(".jp-CodeCell");
  const allCodeCells = [...classicCodeCells, ...labCodeCells];

  allCodeCells.forEach((cell) => {
    if (cell.getAttribute("data-toggle-added") === "true") return;

    let codeInput =
      cell.querySelector(".input") ||
      cell.querySelector(".jp-Cell-inputWrapper");
    if (!codeInput) return;

    const wrapper = document.createElement("div");
    wrapper.classList.add("code-transition");
    codeInput.parentNode.insertBefore(wrapper, codeInput);
    wrapper.appendChild(codeInput);

    const btn = document.createElement("button");
    btn.textContent = "Show Code";
    btn.className = "toggle-btn";

    btn.onclick = () => {
      wrapper.classList.toggle("show");
      btn.textContent = wrapper.classList.contains("show")
        ? "Hide Code"
        : "Show Code";
    };

    cell.insertBefore(btn, wrapper);
    cell.setAttribute("data-toggle-added", "true");
  });

  /* Hide prompts */
  document
    .querySelectorAll(".jp-InputPrompt, .jp-OutputPrompt")
    .forEach((el) => (el.style.display = "none"));

  document.querySelectorAll(".jp-CodeCell pre").forEach((pre) => {
    if (pre.textContent.includes("IPython.display")) {
      const cell = pre.closest(".jp-CodeCell");
      if (cell) {
        cell.style.display = "none";
      }
    }
  });
}

document.addEventListener("DOMContentLoaded", addSmoothToggleButtons);
setTimeout(addSmoothToggleButtons, 1200);
