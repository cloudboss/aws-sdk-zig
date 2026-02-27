pub const AttributeType = enum {
    inclusive,
    exclusive,
    contains,
    before,
    after,
    on,
    between,

    pub const json_field_names = .{
        .inclusive = "INCLUSIVE",
        .exclusive = "EXCLUSIVE",
        .contains = "CONTAINS",
        .before = "BEFORE",
        .after = "AFTER",
        .on = "ON",
        .between = "BETWEEN",
    };
};
