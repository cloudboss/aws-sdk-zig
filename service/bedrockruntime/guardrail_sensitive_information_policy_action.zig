pub const GuardrailSensitiveInformationPolicyAction = enum {
    anonymized,
    blocked,
    none,

    pub const json_field_names = .{
        .anonymized = "ANONYMIZED",
        .blocked = "BLOCKED",
        .none = "NONE",
    };
};
