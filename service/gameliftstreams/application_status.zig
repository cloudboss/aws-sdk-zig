pub const ApplicationStatus = enum {
    initialized,
    processing,
    ready,
    deleting,
    @"error",

    pub const json_field_names = .{
        .initialized = "INITIALIZED",
        .processing = "PROCESSING",
        .ready = "READY",
        .deleting = "DELETING",
        .@"error" = "ERROR",
    };
};
