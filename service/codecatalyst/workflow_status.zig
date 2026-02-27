pub const WorkflowStatus = enum {
    invalid,
    active,

    pub const json_field_names = .{
        .invalid = "INVALID",
        .active = "ACTIVE",
    };
};
