pub const ParentType = enum {
    root,
    organizational_unit,

    pub const json_field_names = .{
        .root = "ROOT",
        .organizational_unit = "ORGANIZATIONAL_UNIT",
    };
};
