import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

const spinner = '<div> Loading more... </div>';

export default class extends Controller {
  static fetching = false;

  static values = {
    url: String,
    page: { type: Number, default: 1 },
  };

  static targets = ["posts", "noRecords"];

  initialize() {
    //needs to target document instead of controller object
    this.scroll = this.scroll.bind(this);
  }

  connect() {
    document.addEventListener("scroll", this.scroll);
  }

  scroll() {
    if (this.#pageEnd && !this.fetching && !this.hasNoRecordsTarget) {

      this.postsTarget.insertAdjastmentHTML("beforeend", spinner);

      this.#loadRecords();
    }
  }

  async #loadRecords() {
    const url = new URL(this.urlValue);
    url.searchParams.set("page", this.pageValue);

    this.fetching = true;

    await get(url.toString(), {
      responseKind: "turbo-stream",
    });

    this.fetching = false;
    this.pageValue += 1;
  }

  get #pageEnd() {
    const { scrollHeight, scrollTop, clientHeight } = document.documentElement;
    return scrollHeight - scrollTop - clientHeight < 40;
  }
}
