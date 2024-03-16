import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggleForm(event) {
    // block for scrolling top when cliked
    event.preventDefault();
    event.stopPropagation();

    // getting the params named form and body from our _comment.html.erb ("comments_form_param" & "comments_body_param")
    const formID = event.params["form"];
    const commentBodyID = event.params["body"];

    // toggles a "d-none" class for edit form and comments body
    const form = document.getElementById(formID);
    form.classList.toggle("d-none");
    const commentBody = document.getElementById(commentBodyID);
    commentBody.classList.toggle("d-none");
  }

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
  }
}
