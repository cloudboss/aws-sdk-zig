pub const DeviceDiscoveryStatus = enum {
    running,
    succeeded,
    failed,
    timed_out,

    pub const json_field_names = .{
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
    };
};
