import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["items"]

  addItem() {
    const index = this.itemsTarget.children.length
  
    this.itemsTarget.insertAdjacentHTML("beforeend", `
      <tr>
        <td>
          <input type="text"
                 name="billing_form[items][${index}][product_code]"
                 placeholder="Product ID">
        </td>
        <td>
          <input type="number"
                 name="billing_form[items][${index}][quantity]"
                 min="1"
                 placeholder="Quantity">
        </td>
      </tr>
    `)
  }  
}
