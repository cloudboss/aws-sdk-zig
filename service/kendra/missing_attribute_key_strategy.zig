pub const MissingAttributeKeyStrategy = enum {
    ignore,
    collapse,
    expand,

    pub const json_field_names = .{
        .ignore = "IGNORE",
        .collapse = "COLLAPSE",
        .expand = "EXPAND",
    };
};
