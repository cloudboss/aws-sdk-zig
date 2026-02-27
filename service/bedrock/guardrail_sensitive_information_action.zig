pub const GuardrailSensitiveInformationAction = enum {
    block,
    anonymize,
    none,

    pub const json_field_names = .{
        .block = "BLOCK",
        .anonymize = "ANONYMIZE",
        .none = "NONE",
    };
};
