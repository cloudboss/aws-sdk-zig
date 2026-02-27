pub const RuleType = enum {
    required,
    hidden,
    field_options,

    pub const json_field_names = .{
        .required = "REQUIRED",
        .hidden = "HIDDEN",
        .field_options = "FIELD_OPTIONS",
    };
};
