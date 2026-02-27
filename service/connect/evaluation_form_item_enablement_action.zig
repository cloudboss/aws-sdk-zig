pub const EvaluationFormItemEnablementAction = enum {
    disable,
    enable,

    pub const json_field_names = .{
        .disable = "DISABLE",
        .enable = "ENABLE",
    };
};
