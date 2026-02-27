pub const FailoverInputSourcePriorityMode = enum {
    no_priority,
    primary_secondary,

    pub const json_field_names = .{
        .no_priority = "NO_PRIORITY",
        .primary_secondary = "PRIMARY_SECONDARY",
    };
};
