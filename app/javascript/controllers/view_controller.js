import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let observer = new IntersectionObserver((entries, observer) => { 
      entries.forEach(entry => {
        // Если элемент видим
        if(entry.isIntersecting){
          // Увеличиваем счетчик просмотров
          fetch('/posts/' + this.element.id + '/view', { 
            method: 'POST',
            headers: {
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
            }
          })
          .then(response => {
            if (!response.ok) {
              throw new Error('Network response was not ok');
            }
            return response.text();
          })
          .then(data => {
            console.log(data);
            document.getElementById('post-views-' + entry.target.id).innerText = Number(data);
          });
        }
      });
    });

    // Наблюдение за элементом
    observer.observe(this.element);
  }
}