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
}
