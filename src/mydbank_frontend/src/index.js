import { mydbank_backend } from "../../declarations/mydbank_backend";

window.addEventListener("load", async function () {
  // console.log('finished loading');
  const currentAmount = await mydbank_backend.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
});


document.querySelector("form").addEventListener("submit", async function (event) {
  event.preventDefault();
  // console.log("Submitted.");

  const button = event.target.querySelector("#submit-btn");

  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  button.setAttribute("disabled", true);

  if (document.getElementById("input-amount").value.length != 0) {
    await mydbank_backend.topUp(inputAmount);
  }

  if (document.getElementById("withdrawal-amount").value.length != 0) {
    await mydbank_backend.withdraw(outputAmount);
  }

  await mydbank_backend.compound();

  update()

  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";

  button.removeAttribute("disabled");

});

async function update() {
  const currentAmount = await mydbank_backend.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
};