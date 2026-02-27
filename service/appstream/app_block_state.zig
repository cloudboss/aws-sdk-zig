pub const AppBlockState = enum {
    inactive,
    active,

    pub const json_field_names = .{
        .inactive = "INACTIVE",
        .active = "ACTIVE",
    };
};
