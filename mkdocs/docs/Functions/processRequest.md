# processRequest

This function processes incoming HTTP requests to gather and respond with statistics about SRT senders and receivers as well as server status. It retrieves data from specific endpoints and formats the statistics for output.

```go
func processRequest(w http.ResponseWriter, r *http.Request) {
    resp, err := getMetrics("/manage/srt_sender_stats")
    if err == nil {
        var result SrtSenders
        if err := json.Unmarshal([]byte(resp), &result); err != nil {
            log.Errorf("Can not unmarshal JSON from /manage/srt_sender_stats")
            w.WriteHeader(503)
            return
        } else {
            for _, rec := range result.SrtSenders {
                fmt.Fprintf(w, "nimble_srt_sender_time { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Time)
                fmt.Fprintf(w, "nimble_srt_sender_window_flow { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Window.Flow)
                fmt.Fprintf(w, "nimble_srt_sender_window_congestion { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Window.Congestion)
                fmt.Fprintf(w, "nimble_srt_sender_window_flight { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Window.Flight)

                fmt.Fprintf(w, "nimble_srt_sender_link_rtt { stream_id=\"%s\", id=\"%s\"} %f\n", rec.Streamid, rec.ID, rec.Stats.Link.Rtt)
                fmt.Fprintf(w, "nimble_srt_sender_link_bandwidth { stream_id=\"%s\", id=\"%s\"} %f\n", rec.Streamid, rec.ID, rec.Stats.Link.MbpsBandwidth)
                fmt.Fprintf(w, "nimble_srt_sender_link_bandwidth_max { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Link.MbpsMaxBandwidth)

                fmt.Fprintf(w, "nimble_srt_sender_recv_packets_received { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.PacketsReceived)
                fmt.Fprintf(w, "nimble_srt_sender_recv_packets_received_retransmitted { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.PacketsReceivedRetransmitted)
                fmt.Fprintf(w, "nimble_srt_sender_recv_packets_lost { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.PacketsLost)
                fmt.Fprintf(w, "nimble_srt_sender_recv_packets_dropped { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.PacketsDropped)
                fmt.Fprintf(w, "nimble_srt_sender_recv_packets_belated { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.PacketsBelated)
                fmt.Fprintf(w, "nimble_srt_sender_recv_naks_sent { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.NAKsSent)
                fmt.Fprintf(w, "nimble_srt_sender_recv_bytes_lost { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.BytesLost)
                fmt.Fprintf(w, "nimble_srt_sender_recv_bytes_dropped { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.BytesDropped)
                fmt.Fprintf(w, "nimble_srt_sender_recv_mbps_rate { stream_id=\"%s\", id=\"%s\"} %f\n", rec.Streamid, rec.ID, rec.Stats.Recv.MbpsRate)
            }
        }
    } else {
        w.WriteHeader(503)
        return
    }
    resp, err = getMetrics("/manage/srt_receiver_stats")
    if err == nil {
        var result SrtReceivers
        if err := json.Unmarshal([]byte(resp), &result); err != nil {
            log.Errorf("Can not unmarshal JSON from /manage/srt_receiver_stats")
            w.WriteHeader(503)
            return
        } else {
            for _, rec := range result.SrtReceivers {
                fmt.Fprintf(w, "nimble_srt_receiver_time { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Time)
                fmt.Fprintf(w, "nimble_srt_receiver_window_flow { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Window.Flow)
                fmt.Fprintf(w, "nimble_srt_receiver_window_congestion { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Window.Congestion)
                fmt.Fprintf(w, "nimble_srt_receiver_window_flight { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Window.Flight)

                fmt.Fprintf(w, "nimble_srt_receiver_link_rtt { stream_id=\"%s\", id=\"%s\"} %f\n", rec.Streamid, rec.ID, rec.Stats.Link.Rtt)
                fmt.Fprintf(w, "nimble_srt_receiver_link_bandwidth { stream_id=\"%s\", id=\"%s\"} %f\n", rec.Streamid, rec.ID, rec.Stats.Link.MbpsBandwidth)
                fmt.Fprintf(w, "nimble_srt_receiver_link_bandwidth_max { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Link.MbpsMaxBandwidth)

                fmt.Fprintf(w, "nimble_srt_receiver_recv_packets_received { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.PacketsReceived)
                fmt.Fprintf(w, "nimble_srt_receiver_recv_packets_received_retransmitted { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.PacketsReceivedRetransmitted)
                fmt.Fprintf(w, "nimble_srt_receiver_recv_packets_lost { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.PacketsLost)
                fmt.Fprintf(w, "nimble_srt_receiver_recv_packets_dropped { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.PacketsDropped)
                fmt.Fprintf(w, "nimble_srt_receiver_recv_packets_belated { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.PacketsBelated)
                fmt.Fprintf(w, "nimble_srt_receiver_recv_naks_sent { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.NAKsSent)
                fmt.Fprintf(w, "nimble_srt_receiver_recv_bytes_lost { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.BytesLost)
                fmt.Fprintf(w, "nimble_srt_receiver_recv_bytes_dropped { stream_id=\"%s\", id=\"%s\"} %d\n", rec.Streamid, rec.ID, rec.Stats.Recv.BytesDropped)
                fmt.Fprintf(w, "nimble_srt_receiver_recv_mbps_rate { stream_id=\"%s\", id=\"%s\"} %f\n", rec.Streamid, rec.ID, rec.Stats.Recv.MbpsRate)
            }
        }
    } else {
        w.WriteHeader(503)
        return
    }
    // server_status
    resp, err = getMetrics("/manage/server_status")
    if err == nil {
        var result ServerStatus
        if err := json.Unmarshal([]byte(resp), &result); err != nil {
            log.Errorf("Can not unmarshal JSON from /manage/server_status")
            w.WriteHeader(503)
            return
        } else {
            fmt.Fprintf(w, "nimble_connections %d\n", result.Connections)
            fmt.Fprintf(w, "nimble_outrate %d\n", result.OutRate)
            fmt.Fprintf(w, "nimble_ram_cache_size %d\n", result.RAMCacheSize)
            fmt.Fprintf(w, "nimble_file_cache_size %d\n", result.FileCacheSize)
            fmt.Fprintf(w, "nimble_ram_cache_size_max %d\n", result.MaxRAMCacheSize)
            fmt.Fprintf(w, "nimble_file_cache_size_max %d\n", result.MaxFileCacheSize)
            fmt.Fprintf(w, "nimble_sysinfo_ap %d\n", result.SysInfo.Ap)
            fmt.Fprintf(w, "nimble_sysinfo_scl %s\n", result.SysInfo.Scl)
            fmt.Fprintf(w, "nimble_sysinfo_tpms %d\n", result.SysInfo.Tpms)
            fmt.Fprintf(w, "nimble_sysinfo_fpms %d\n", result.SysInfo.Fpms)
            fmt.Fprintf(w, "nimble_sysinfo_tsss %d\n", result.SysInfo.Tsss)
            fmt.Fprintf(w, "nimble_sysinfo_fsss %d\n", result.SysInfo.Fsss)
        }
    } else {
        w.WriteHeader(503)
        return
    }
}
```
