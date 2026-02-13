pub const ManagedStatus = enum {
    all,
    managed,
    unmanaged,

    pub const json_field_names = .{
        .all = "ALL",
        .managed = "MANAGED",
        .unmanaged = "UNMANAGED",
    };
};
