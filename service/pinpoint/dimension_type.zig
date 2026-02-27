pub const DimensionType = enum {
    inclusive,
    exclusive,

    pub const json_field_names = .{
        .inclusive = "INCLUSIVE",
        .exclusive = "EXCLUSIVE",
    };
};
