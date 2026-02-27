pub const GuardrailAction = enum {
    none,
    guardrail_intervened,

    pub const json_field_names = .{
        .none = "NONE",
        .guardrail_intervened = "GUARDRAIL_INTERVENED",
    };
};
