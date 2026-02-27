pub const EnvironmentStatus = enum {
    @"error",
    creating,
    connecting,
    ready,
    stopping,
    stopped,
    deleting,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .creating = "CREATING",
        .connecting = "CONNECTING",
        .ready = "READY",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .deleting = "DELETING",
    };
};
