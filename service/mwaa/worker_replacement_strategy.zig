pub const WorkerReplacementStrategy = enum {
    forced,
    graceful,

    pub const json_field_names = .{
        .forced = "FORCED",
        .graceful = "GRACEFUL",
    };
};
