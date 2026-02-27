pub const SlotShape = enum {
    scalar,
    list,

    pub const json_field_names = .{
        .scalar = "Scalar",
        .list = "List",
    };
};
