pub const CEType = enum {
    managed,
    unmanaged,

    pub const json_field_names = .{
        .managed = "MANAGED",
        .unmanaged = "UNMANAGED",
    };
};
