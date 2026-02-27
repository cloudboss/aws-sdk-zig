pub const ConfigurationStatus = enum {
    completed,
    failed,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
