pub const RealtimeEndpointStatus = enum {
    none,
    ready,
    updating,
    failed,

    pub const json_field_names = .{
        .none = "NONE",
        .ready = "READY",
        .updating = "UPDATING",
        .failed = "FAILED",
    };
};
