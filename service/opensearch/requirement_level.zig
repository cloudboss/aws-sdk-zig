pub const RequirementLevel = enum {
    required,
    optional,
    none,

    pub const json_field_names = .{
        .required = "REQUIRED",
        .optional = "OPTIONAL",
        .none = "NONE",
    };
};
