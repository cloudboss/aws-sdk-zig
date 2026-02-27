pub const UsageState = enum {
    in_use,
    not_in_use,

    pub const json_field_names = .{
        .in_use = "IN_USE",
        .not_in_use = "NOT_IN_USE",
    };
};
