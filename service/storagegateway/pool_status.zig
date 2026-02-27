pub const PoolStatus = enum {
    active,
    deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deleted = "DELETED",
    };
};
