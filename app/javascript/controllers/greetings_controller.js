import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "timedResponse" ];
  static values = { greetings: Array };

  connect() {
    const now = (new Date).getHours();

    if (now <= 4) {
      this.timedResponseTarget.innerText = this.greetingsValue[0];
    } else if (now < 12){
      this.timedResponseTarget.innerText = this.greetingsValue[1];
    } else if (now < 18){
      this.timedResponseTarget.innerText = this.greetingsValue[2];
    } else {
      this.timedResponseTarget.innerText = this.greetingsValue[3];
    }
  }
}
