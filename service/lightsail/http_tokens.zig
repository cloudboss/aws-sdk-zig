pub const HttpTokens = enum {
    optional,
    required,

    pub const json_field_names = .{
        .optional = "optional",
        .required = "required",
    };
};
