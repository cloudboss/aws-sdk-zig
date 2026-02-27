pub const DeleteResources = enum {
    all,
    default,

    pub const json_field_names = .{
        .all = "ALL",
        .default = "DEFAULT",
    };
};
