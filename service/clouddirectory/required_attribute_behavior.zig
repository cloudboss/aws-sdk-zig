pub const RequiredAttributeBehavior = enum {
    required_always,
    not_required,

    pub const json_field_names = .{
        .required_always = "REQUIRED_ALWAYS",
        .not_required = "NOT_REQUIRED",
    };
};
