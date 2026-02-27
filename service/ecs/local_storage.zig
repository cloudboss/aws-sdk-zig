pub const LocalStorage = enum {
    included,
    required,
    excluded,

    pub const json_field_names = .{
        .included = "INCLUDED",
        .required = "REQUIRED",
        .excluded = "EXCLUDED",
    };
};
