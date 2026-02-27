/// Types of sensitive data detection scope
pub const SensitiveDataDetectionScopeType = enum {
    /// Standard PII detection
    standard,
    /// Custom PII detection
    custom,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .custom = "CUSTOM",
    };
};
