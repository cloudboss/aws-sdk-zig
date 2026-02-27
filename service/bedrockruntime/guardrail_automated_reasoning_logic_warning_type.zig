pub const GuardrailAutomatedReasoningLogicWarningType = enum {
    always_false,
    always_true,

    pub const json_field_names = .{
        .always_false = "ALWAYS_FALSE",
        .always_true = "ALWAYS_TRUE",
    };
};
