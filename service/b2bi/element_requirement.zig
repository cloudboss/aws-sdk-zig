pub const ElementRequirement = enum {
    optional,
    mandatory,

    pub const json_field_names = .{
        .optional = "OPTIONAL",
        .mandatory = "MANDATORY",
    };
};
