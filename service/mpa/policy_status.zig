pub const PolicyStatus = enum {
    attachable,
    deprecated,

    pub const json_field_names = .{
        .attachable = "ATTACHABLE",
        .deprecated = "DEPRECATED",
    };
};
