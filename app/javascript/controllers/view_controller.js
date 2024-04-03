import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let timer;
    let observer = new IntersectionObserver((entries, observer) => { 
      entries.forEach(entry => {
        if(entry.isIntersecting){
          // Запускаем таймер, если элемент видим
          timer = setTimeout(() => {
            fetch('/posts/' + this.element.id + '/view', { 
              method: 'POST',
              headers: {
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
                'Accept': 'text/vnd.turbo-stream.html',
              }
            })
            .then(response => {
              if (!response.ok) {
                throw new Error('Network response was not ok');
              }
              return response.text();
            })
            .then(data => {
              console.log(data); // для ручной проверки
              if (data) {
                document.getElementById('post-views-' + entry.target.id).innerText = data;
              }
            });
          }, 2500); // Запускаем таймер на 3 секунды
        } else {
          // Останавливаем таймер, если элемент больше не видим
          clearTimeout(timer);
        }
      });
    });

    // Наблюдение за элементом
    observer.observe(this.element);
  }
}
