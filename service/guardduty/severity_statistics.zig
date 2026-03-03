/// Information about severity level for each finding type.
pub const SeverityStatistics = struct {
    /// The timestamp at which a finding type for a specific severity was last
    /// generated.
    last_generated_at: ?i64 = null,

    /// The severity level associated with each finding type.
    severity: ?f64 = null,

    /// The total number of findings associated with this severity.
    total_findings: ?i32 = null,

    pub const json_field_names = .{
        .last_generated_at = "LastGeneratedAt",
        .severity = "Severity",
        .total_findings = "TotalFindings",
    };
};
