# What is Nimble Exporter

Nimble Exporter is a Prometheus exporter to server application that processes and reports metrics related to Secure Reliable Transport (SRT) senders. 
It is designed to interact with a streaming server to retrieve and display statistics about SRT streams. 
When a request from Prometheus, Nimble Exporter contacts the application via http api, gets statistics in json, and gives it to Prometheus in a format it understands.

**Request:** Send a GET request to http://<server_address>:9017/ (replace <server_address> with the actual address you're using).

**Response:**

| Status Code | Body | Use Case |
|---|---|---|
| 200 OK | Typically empty since the handler does not write anything to the response body. | This endpoint is useful for checking if the server is running and responding to HTTP requests, serving as a basic health check. |

**Request:** Send a GET request to http://<server_address>:9017/metrics.

**Response:**

| Status Code | Body | Use Case |
|---|---|---|
| 200 OK if the processRequest function successfully retrieves and processes the metrics. | Contains metrics data in a format suitable for Prometheus, including information about SRT senders, receivers, and server status. | <li> nimble_srt_sender_time { stream_id="stream1", id="sender1"} 162 </li> <li> nimble_srt_sender_window_flow { stream_id="stream1", id="sender1"} 50 </li> <li> nimble_connections 100 </li> <li> nimble_outrate 500 </li> |

**Error Handling:** If there are issues fetching the metrics (e.g., connectivity problems with the Nimble service), the response might have a status code 503 Service Unavailable, and the body might contain an error message logged by the application.
