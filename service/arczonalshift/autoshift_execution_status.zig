pub const AutoshiftExecutionStatus = enum {
    active,
    completed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .completed = "COMPLETED",
    };
};
