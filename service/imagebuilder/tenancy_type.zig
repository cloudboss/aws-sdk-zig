pub const TenancyType = enum {
    default,
    dedicated,
    host,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .dedicated = "DEDICATED",
        .host = "HOST",
    };
};
