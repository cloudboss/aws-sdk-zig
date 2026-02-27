pub const ProbeState = enum {
    pending,
    active,
    inactive,
    @"error",
    deleting,
    deleted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .@"error" = "ERROR",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
