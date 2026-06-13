const price = () => {
  const priceInput = document.getElementById("item-price");
  if (priceInput === null) return;
  priceInput.addEventListener("input", () => {
    const value = priceInput.value;
    const fee = Math.floor(value * 0.1);
    document.getElementById("add-tax-price").innerHTML = fee.toLocaleString();
    document.getElementById("profit").innerHTML = Math.floor(value - fee).toLocaleString();
  });
};
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
