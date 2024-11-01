# ServerStatus

This struct is designed to represent the status of a server, encapsulating various metrics and information about its performance and configuration.

```
type ServerStatus struct {
    Connections int `json:"Connections"`
    OutRate     int `json:"OutRate"`
    SysInfo     struct {
        Ap   int    `json:"ap"`
        Scl  string `json:"scl"`
        Tpms int64  `json:"tpms"`
        Fpms int64  `json:"fpms"`
        Tsss int    `json:"tsss"`
        Fsss int    `json:"fsss"`
    } `json:"SysInfo"`
    RAMCacheSize     int `json:"RamCacheSize"`
    FileCacheSize    int `json:"FileCacheSize"`
    MaxRAMCacheSize  int `json:"MaxRamCacheSize"`
    MaxFileCacheSize int `json:"MaxFileCacheSize"`
}
```
