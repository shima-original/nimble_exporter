# StrReceivers

This struct is used to represent a collection of SRT (Secure Reliable Transport) receivers along with their associated statistics and state information.

```go
type SrtReceivers struct {
    SrtReceivers []struct {
        ID       string `json:"id"`
        Streamid string `json:"streamid"`
        State    string `json:"state"`
        Stats    struct {
            Time   int `json:"time"`
            Window struct {
                Flow       int `json:"flow"`
                Congestion int `json:"congestion"`
                Flight     int `json:"flight"`
            } `json:"window"`
            Link struct {
                Rtt              float64 `json:"rtt"`
                MbpsBandwidth    float64 `json:"mbpsBandwidth"`
                MbpsMaxBandwidth int     `json:"mbpsMaxBandwidth"`
            } `json:"link"`
            Recv struct {
                PacketsReceived              int     `json:"packetsReceived"`
                PacketsReceivedRetransmitted int     `json:"packetsReceivedRetransmitted"`
                PacketsLost                  int     `json:"packetsLost"`
                PacketsDropped               int     `json:"packetsDropped"`
                PacketsBelated               int     `json:"packetsBelated"`
                NAKsSent                     int     `json:"NAKsSent"`
                BytesReceived                int     `json:"bytesReceived"`
                BytesLost                    int     `json:"bytesLost"`
                BytesDropped                 int     `json:"bytesDropped"`
                MbpsRate                     float64 `json:"mbpsRate"`
            } `json:"recv"`
        } `json:"stats"`
    } `json:"SrtReceivers"`
}
```
