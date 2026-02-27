pub const EvaluatorType = enum {
    builtin,
    custom,

    pub const json_field_names = .{
        .builtin = "BUILTIN",
        .custom = "CUSTOM",
    };
};
