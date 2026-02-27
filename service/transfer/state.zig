/// Describes the condition of a file transfer protocol-enabled server with
/// respect to its ability to perform file operations. There are six possible
/// states: `OFFLINE`, `ONLINE`, `STARTING`, `STOPPING`, `START_FAILED`, and
/// `STOP_FAILED`.
///
/// `OFFLINE` indicates that the server exists, but that it is not available for
/// file operations. `ONLINE` indicates that the server is available to perform
/// file operations. `STARTING` indicates that the server's was instantiated,
/// but the server is not yet available to perform file operations. Under normal
/// conditions, it can take a couple of minutes for the server to be completely
/// operational. Both `START_FAILED` and `STOP_FAILED` are error conditions.
pub const State = enum {
    offline,
    online,
    starting,
    stopping,
    start_failed,
    stop_failed,

    pub const json_field_names = .{
        .offline = "OFFLINE",
        .online = "ONLINE",
        .starting = "STARTING",
        .stopping = "STOPPING",
        .start_failed = "START_FAILED",
        .stop_failed = "STOP_FAILED",
    };
};
