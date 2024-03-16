import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  reply(event) {
    event.preventDefault();

    // Получаем данные из data-атрибутов
    const commentId = event.currentTarget.dataset.commentId;
    const userName = event.currentTarget.dataset.userName;

    // Находим поля формы и устанавливаем значения
    const commentIdField = document.getElementById('parent_id_field');
    commentIdField.value = commentId;
    const userNameDiv = document.getElementById('user_name');
    userNameDiv.textContent = userName;
    const visibleDiv = document.getElementById('reply_to');
    visibleDiv.classList.toggle('d-none');
    const submitButton = document.getElementById('submit_button');
    submitButton.value = 'Reply';

    // Устанавливаем фокус на форму
    const form = document.getElementById('comment_form');
    form.focus();
  }

  cancel(event) {
    event.preventDefault();

    // Скрываем другой div
    const visibleDiv = document.getElementById('reply_to');
    visibleDiv.classList.add('d-none');

    // Очищаем поле ввода
    const form = document.getElementById('comment_form');
    form.reset();
    const submitButton = document.getElementById('submit_button');
    submitButton.value = 'Add comment';
  }
}
