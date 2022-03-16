function item() {
  const priceInput = document.getElementById("item-price");

  priceInput.addEventListener('input', () => {
    const inputValue = priceInput.value;
    
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
    const addTaxPrice = parseInt(inputValue * 0.1, 10);

    const salesProfit = document.getElementById("profit");
    salesProfit.innerHTML = Math.floor(inputValue - addTaxPrice);

  });
};

window.addEventListener('load', item);