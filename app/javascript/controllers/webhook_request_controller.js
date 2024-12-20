import { Controller } from "@hotwired/stimulus"
import consumer from "channels/consumer"

// Connects to data-controller="webhook-request"
export default class extends Controller {
  static values = {
    webhookSlug: String // Define the value type
  }

  connect() {
    this.channel = consumer.subscriptions.create(
        { 
            channel: 'WebhookRequestChannel',
            webhook_slug: this.webhookSlugValue,
        },
        {
            received: this.received.bind(this)
        }
    )
  }

  disconnect() {
    console.log("WebhookRequestController disconnected")
    // Cleanup can be done here
  }

  // Example method to handle incoming webhook data
  received(data) {
    const tbody = document.getElementById("webhook-request-list");
    const newRow = document.createElement("tr");
    newRow.innerHTML = `
        <td><a href="/webhooks/${data.webhook_uuid}/webhook_requests/${data.id}">${data.id}</a></td>
        <td>${data.method}</td>
        <td>${data.url}</td>
        <td>${data.ip || 'N/A'}</td>
        <td>${data.created_at}</td>
    `;
    tbody.insertBefore(newRow, tbody.firstChild);
  }
}
