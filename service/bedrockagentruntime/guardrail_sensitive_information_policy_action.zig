pub const GuardrailSensitiveInformationPolicyAction = enum {
    blocked,
    anonymized,

    pub const json_field_names = .{
        .blocked = "BLOCKED",
        .anonymized = "ANONYMIZED",
    };
};
