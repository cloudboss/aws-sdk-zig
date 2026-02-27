pub const ScalingStatusCode = enum {
    inactive,
    partially_active,
    active,

    pub const json_field_names = .{
        .inactive = "Inactive",
        .partially_active = "PartiallyActive",
        .active = "Active",
    };
};
