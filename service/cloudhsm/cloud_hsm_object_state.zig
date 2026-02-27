pub const CloudHsmObjectState = enum {
    ready,
    updating,
    degraded,

    pub const json_field_names = .{
        .ready = "READY",
        .updating = "UPDATING",
        .degraded = "DEGRADED",
    };
};
