pub const InstanceStatus = enum {
    in_use,
    preparing,
    available,
    not_available,

    pub const json_field_names = .{
        .in_use = "IN_USE",
        .preparing = "PREPARING",
        .available = "AVAILABLE",
        .not_available = "NOT_AVAILABLE",
    };
};
