pub const WorkloadEstimateStatus = enum {
    updating,
    valid,
    invalid,
    action_needed,

    pub const json_field_names = .{
        .updating = "UPDATING",
        .valid = "VALID",
        .invalid = "INVALID",
        .action_needed = "ACTION_NEEDED",
    };
};
