pub const PropertyRole = enum {
    primary,
    id,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .id = "ID",
    };
};
