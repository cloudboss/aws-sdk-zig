/// Options for sensitive information action.
pub const GuardrailSensitiveInformationAction = enum {
    block,
    anonymize,

    pub const json_field_names = .{
        .block = "BLOCK",
        .anonymize = "ANONYMIZE",
    };
};
