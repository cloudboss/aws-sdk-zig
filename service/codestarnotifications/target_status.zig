pub const TargetStatus = enum {
    pending,
    active,
    @"unreachable",
    inactive,
    deactivated,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .@"unreachable" = "UNREACHABLE",
        .inactive = "INACTIVE",
        .deactivated = "DEACTIVATED",
    };
};
