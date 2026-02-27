pub const Shape = enum {
    scalar,
    list,
    composite,

    pub const json_field_names = .{
        .scalar = "SCALAR",
        .list = "LIST",
        .composite = "COMPOSITE",
    };
};
