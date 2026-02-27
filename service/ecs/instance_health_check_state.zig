pub const InstanceHealthCheckState = enum {
    ok,
    impaired,
    insufficient_data,
    initializing,

    pub const json_field_names = .{
        .ok = "OK",
        .impaired = "IMPAIRED",
        .insufficient_data = "INSUFFICIENT_DATA",
        .initializing = "INITIALIZING",
    };
};
