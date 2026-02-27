pub const StringDimensionType = enum {
    inclusive,
    exclusive,
    contains,
    begins_with,
    ends_with,

    pub const json_field_names = .{
        .inclusive = "INCLUSIVE",
        .exclusive = "EXCLUSIVE",
        .contains = "CONTAINS",
        .begins_with = "BEGINS_WITH",
        .ends_with = "ENDS_WITH",
    };
};
