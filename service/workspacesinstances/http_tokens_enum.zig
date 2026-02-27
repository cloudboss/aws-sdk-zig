pub const HttpTokensEnum = enum {
    optional,
    required,

    pub const json_field_names = .{
        .optional = "OPTIONAL",
        .required = "REQUIRED",
    };
};
