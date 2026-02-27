pub const ResourcesNumberField = enum {
    total_findings,
    severity_other,
    severity_fatal,
    severity_critical,
    severity_high,
    severity_medium,
    severity_low,
    severity_informational,
    severity_unknown,

    pub const json_field_names = .{
        .total_findings = "TOTAL_FINDINGS",
        .severity_other = "SEVERITY_OTHER",
        .severity_fatal = "SEVERITY_FATAL",
        .severity_critical = "SEVERITY_CRITICAL",
        .severity_high = "SEVERITY_HIGH",
        .severity_medium = "SEVERITY_MEDIUM",
        .severity_low = "SEVERITY_LOW",
        .severity_informational = "SEVERITY_INFORMATIONAL",
        .severity_unknown = "SEVERITY_UNKNOWN",
    };
};
