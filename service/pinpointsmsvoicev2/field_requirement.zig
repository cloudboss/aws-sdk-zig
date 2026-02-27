pub const FieldRequirement = enum {
    required,
    conditional,
    optional,

    pub const json_field_names = .{
        .required = "REQUIRED",
        .conditional = "CONDITIONAL",
        .optional = "OPTIONAL",
    };
};
