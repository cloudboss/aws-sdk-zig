pub const ModelVariantAction = enum {
    retain,
    remove,
    promote,

    pub const json_field_names = .{
        .retain = "RETAIN",
        .remove = "REMOVE",
        .promote = "PROMOTE",
    };
};
