pub const RadiusStatus = enum {
    creating,
    completed,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
