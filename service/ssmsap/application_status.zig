pub const ApplicationStatus = enum {
    activated,
    starting,
    stopped,
    stopping,
    failed,
    registering,
    deleting,
    unknown,

    pub const json_field_names = .{
        .activated = "ACTIVATED",
        .starting = "STARTING",
        .stopped = "STOPPED",
        .stopping = "STOPPING",
        .failed = "FAILED",
        .registering = "REGISTERING",
        .deleting = "DELETING",
        .unknown = "UNKNOWN",
    };
};
