# getMetrics

This function retrieves metrics data from a specified path on a Nimble storage device or service. It constructs an HTTP GET request, sends it to the server, and returns the response body as a string, handling authentication if necessary.

```go
func getMetrics(path string) (string, error) {
    auth_string := ""
    if len(*NimbleAuthSalt) > 0 && len(*NimbleAuthHash) > 0 {
        auth_string = "?salt=" + *NimbleAuthSalt + "&hash=" + *NimbleAuthHash
    }
    connect_string := *NimbleAddress + path + auth_string

    client := &http.Client{Timeout: 2 * time.Second}
    resp, err := client.Get(connect_string)

    log.Debugf("Connecting to %s", *NimbleAddress)
    if err != nil {
        log.Errorf("Cant connect to %s", *NimbleAddress)
        return "", errors.New("cant connect to nimble")
    }
    defer resp.Body.Close()
    if resp.StatusCode != 200 {
        log.Errorf("Got %d response code", resp.StatusCode)
        return "", errors.New("cant get metrics")
    }
    body, _ := io.ReadAll(resp.Body)
    return string(body), nil
}
```
