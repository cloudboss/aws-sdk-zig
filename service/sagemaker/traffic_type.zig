pub const TrafficType = enum {
    phases,
    stairs,

    pub const json_field_names = .{
        .phases = "PHASES",
        .stairs = "STAIRS",
    };
};
