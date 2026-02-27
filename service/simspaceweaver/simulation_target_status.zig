pub const SimulationTargetStatus = enum {
    unknown,
    started,
    stopped,
    deleted,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .started = "STARTED",
        .stopped = "STOPPED",
        .deleted = "DELETED",
    };
};
