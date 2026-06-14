const pay = () => {
  if (typeof Payjp === "undefined") return;

  const form = document.getElementById("charge-form");
  if (!form) return;

  const numberForm = document.getElementById("number-form");
  const expiryForm = document.getElementById("expiry-form");
  const cvcForm = document.getElementById("cvc-form");
  if (!numberForm || !expiryForm || !cvcForm) return;

  // Turboのキャッシュ復元などで残った古いiframeを消して、必ず作り直す
  numberForm.innerHTML = "";
  expiryForm.innerHTML = "";
  cvcForm.innerHTML = "";

  const payjp = Payjp(form.dataset.payjpPublicKey);
  const elements = payjp.elements();
  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  const submitHandler = (e) => {
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
  };

  // submitリスナーの重複登録を防ぐ
  if (form._payHandler) form.removeEventListener("submit", form._payHandler);
  form._payHandler = submitHandler;
  form.addEventListener("submit", submitHandler);
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
