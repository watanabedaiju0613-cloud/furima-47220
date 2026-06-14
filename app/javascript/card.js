const pay = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  const numberForm = document.getElementById("number-form");
  // 購入ページ以外、または既にマウント済みなら何もしない
  if (!numberForm || numberForm.children.length > 0) return;

  const publicKey = form.dataset.payjpPublicKey;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();
  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        form.submit();
      } else {
        const token = response.id;
        const tokenObj = `<input value="${token}" type="hidden" name="token">`;
        form.insertAdjacentHTML("beforeend", tokenObj);
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        form.submit();
      }
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
