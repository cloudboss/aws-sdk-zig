pub const AutomatedReasoningCheckLogicWarningType = enum {
    always_true,
    always_false,

    pub const json_field_names = .{
        .always_true = "ALWAYS_TRUE",
        .always_false = "ALWAYS_FALSE",
    };
};
