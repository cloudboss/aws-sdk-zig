pub const ObjectTags = enum {
    preserve,
    none,

    pub const json_field_names = .{
        .preserve = "PRESERVE",
        .none = "NONE",
    };
};
