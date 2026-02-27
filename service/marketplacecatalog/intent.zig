pub const Intent = enum {
    validate,
    apply,

    pub const json_field_names = .{
        .validate = "VALIDATE",
        .apply = "APPLY",
    };
};
