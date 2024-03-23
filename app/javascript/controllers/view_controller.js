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
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            }
          })
          .then(response => {
            if (!response.ok) {
              throw new Error('Network response was not ok');
            }
            return response.json();
          })
          .then(data => console.log(this.element.id));

          console.log(this.element.id)
          
          observer.unobserve(entry.target);
        }
      });
    });

    // Наблюдение за элементом
    observer.observe(this.element);
  }
}