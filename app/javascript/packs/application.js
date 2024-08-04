import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "bootstrap";
import "../stylesheets/application";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

document.addEventListener("turbolinks:load", function () {
  console.log("JavaScript loaded");

  if (typeof jQuery !== 'undefined') {
    console.log("jQuery version:", jQuery.fn.jquery);
  } else {
    console.log("jQuery is not loaded");
  }

  const deleteModal = $('#deleteModal');
  const deleteModalBody = $('#deleteModalBody');
  const confirmDeleteButton = $('#confirmDeleteButton');

  if (deleteModal.length && deleteModalBody.length && confirmDeleteButton.length) {
    console.log("Modal elements found");
  } else {
    console.log("Modal elements not found");
  }

  console.log("Bootstrap loaded:", typeof $.fn.modal === 'function');

  // モーダルが表示される際のイベントリスナーを追加
  deleteModal.on('show.bs.modal', function(event) {
    const button = $(event.relatedTarget);
    const hotelName = button.data('hotel-name');
    const checkIn = button.data('check-in');
    const checkOut = button.data('check-out');
    const numberOfPeople = button.data('number-of-people');
    const deleteUrl = button.data('delete-url');
    const isReservation = button.data('is-reservation');
    const imageSrc = button.data('image-src');
    const price = button.data('price');

    console.log("hotelName:", hotelName);
    console.log("checkIn:", checkIn);
    console.log("checkOut:", checkOut);
    console.log("numberOfPeople:", numberOfPeople);
    console.log("deleteUrl:", deleteUrl);
    console.log("isReservation:", isReservation);
    console.log("imageSrc:", imageSrc);
    console.log("price:", price);

    let modalContent;
    if (isReservation) {
      modalContent = `
        <div class="ConfirmBody">
          <img class="ConfirmBody__image" src="${imageSrc}" alt="${hotelName}">
          <div>
            ${hotelName}<br>
            ${checkIn} ~ ${checkOut}<br>
            ${numberOfPeople}人<br>
            ¥${price}
          </div>
        </div>
        よろしければ「削除」ボタンを押してください。
      `;
    } else {
      modalContent = `
        <div class="ConfirmBody">
          <img class="ConfirmBody__image" src="${imageSrc}" alt="${hotelName}">
          <div>
            ${hotelName}<br>
            ¥${price}〜 / 日
          </div>
        </div>
        よろしければ「削除」ボタンを押してください。
      `;
    }

    deleteModalBody.html(modalContent);

    // 削除ボタンのイベントリスナーを設定
    confirmDeleteButton.off('click').on('click', function() {
      console.log("Delete button clicked"); // クリックイベントのデバッグメッセージ
      console.log("Sending DELETE request to:", deleteUrl);

      Rails.ajax({
        url: deleteUrl,
        type: "DELETE",
        success: function(data) {
          console.log("Delete successful:", data);
          location.reload(); // 成功時にページをリロード
        },
        error: function(err) {
          console.log("Delete failed:", err);
        }
      });
    });
  });

  const accountMenuToggle = document.querySelector('.account-menu-toggle');
  const accountMenu = document.querySelector('.account-menu');

  if (accountMenuToggle && accountMenu) {
    accountMenuToggle.addEventListener('click', function(event) {
      event.preventDefault();
      accountMenuToggle.parentElement.classList.toggle('show');
    });

    document.addEventListener('click', function(event) {
      if (!accountMenuToggle.contains(event.target) && !accountMenu.contains(event.target)) {
        accountMenuToggle.parentElement.classList.remove('show');
      }
    });
  }

  const dropdowns = document.querySelectorAll('.dropdown-toggle');
  dropdowns.forEach(dropdown => {
    dropdown.addEventListener('click', function(event) {
      event.preventDefault();
      const menu = this.nextElementSibling;
      menu.classList.toggle('show');
    });
  });

  document.addEventListener('click', function(event) {
    dropdowns.forEach(dropdown => {
      const menu = dropdown.nextElementSibling;
      if (menu && !dropdown.contains(event.target) && !menu.contains(event.target)) {
        menu.classList.remove('show');
      }
    });
  });

  // 予約フォームのバリデーションを追加
  const checkInField = document.querySelector("input[name='check_in']");
  const checkOutField = document.querySelector("input[name='check_out']");
  const numberOfPeopleField = document.querySelector("input[name='number_of_people']");
  const reservationForm = document.querySelector("#reservation-form");

  if (checkInField && checkOutField && numberOfPeopleField && reservationForm) {
    // 日本の現在の日付を取得
    const now = new Date();
    const JST = new Date(now.toLocaleString("en-US", {timeZone: "Asia/Tokyo"}));
    const today = JST.toISOString().split('T')[0];

    console.log("Today (JST):", today); // Debugging line to confirm the date

    // 日付フィールドの最小値を今日の日付に設定
    checkInField.setAttribute('min', today);
    checkOutField.setAttribute('min', today);

    // エラーメッセージ用のコンテナを追加
    const errorContainer = document.createElement('div');
    errorContainer.className = 'alert alert-danger';
    errorContainer.style.display = 'none';
    reservationForm.prepend(errorContainer);

    // フォーム送信時のバリデーション
    reservationForm.addEventListener("submit", function(event) {
      const checkInDate = new Date(checkInField.value);
      const checkOutDate = new Date(checkOutField.value);
      const numberOfPeople = parseInt(numberOfPeopleField.value, 10);
      let errors = [];

      // 入力項目が不足しているかチェック
      if (!checkInField.value || !checkOutField.value || !numberOfPeopleField.value) {
        errors.push("すべての入力項目を入力してください。");
      }

      // 人数バリデーション
      if (numberOfPeople < 1) {
        errors.push("人数は1以上に設定してください。");
      }

      // チェックイン・チェックアウト日付バリデーション
      if (checkInDate >= checkOutDate) {
        errors.push("チェックアウト日はチェックイン日の翌日以降に設定してください。");
      }

      // 日付が過去でないか確認
      if (checkInDate < new Date(today) || checkOutDate < new Date(today)) {
        errors.push("チェックイン・チェックアウト日は過去の日付を設定できません。");
      }

      if (errors.length > 0) {
        event.preventDefault();
        errorContainer.innerHTML = errors.join('<br>');
        errorContainer.style.display = 'block';
      } else {
        errorContainer.style.display = 'none';
      }
    });
  }
});
