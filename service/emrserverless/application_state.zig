pub const ApplicationState = enum {
    creating,
    created,
    starting,
    started,
    stopping,
    stopped,
    terminated,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .starting = "STARTING",
        .started = "STARTED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .terminated = "TERMINATED",
    };
};
