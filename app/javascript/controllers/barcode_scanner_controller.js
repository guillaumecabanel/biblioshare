import { Controller } from "stimulus";
import Quagga from "quagga/dist/quagga";

export default class extends Controller {
  static targets = [ "camArea", "form", "input" ]

  connect() {
    Quagga.init({
      locate: true,
      inputStream : {
        name : "Live",
        type : "LiveStream",
        target: this.camAreaTarget,
      },
      decoder : {
        readers : [
          "code_128_reader",
          "ean_reader",
          "ean_8_reader",
          "code_39_reader",
          "code_39_vin_reader",
          "codabar_reader",
          "upc_reader",
          "upc_e_reader",
          "i2of5_reader",
          "2of5_reader",
          "code_93_reader"
        ],
        debug: {
          drawBoundingBox: true,
        }
      }
    }, (err) => {
        if (err) {
            console.log(err);
            return
        }

        Quagga.onDetected((data) => {
          if (data.codeResult.startInfo.error < 0.1) {
            this.inputTarget.value = data.codeResult.code;
            Quagga.stop();
            this.formTarget.submit();
          }
        });
        Quagga.start();
    });
  };

  disconnect() {
    Quagga.stop();
  }
}
