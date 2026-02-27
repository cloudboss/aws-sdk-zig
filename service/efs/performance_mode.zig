pub const PerformanceMode = enum {
    general_purpose,
    max_io,

    pub const json_field_names = .{
        .general_purpose = "GENERAL_PURPOSE",
        .max_io = "MAX_IO",
    };
};
