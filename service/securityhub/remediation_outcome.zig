/// The outcome from resolving the remediation target.
pub const RemediationOutcome = struct {
    /// The number of associated exposure findings that are resolved by remediating
    /// the target.
    resolved_findings_count: i32,

    /// The number of associated exposure findings whose severity is reduced by
    /// remediating the target.
    severity_reduction_findings_count: i32,

    /// The number of associated exposure findings whose severity is unchanged by
    /// remediating the target.
    severity_unchanged_count: i32,

    pub const json_field_names = .{
        .resolved_findings_count = "ResolvedFindingsCount",
        .severity_reduction_findings_count = "SeverityReductionFindingsCount",
        .severity_unchanged_count = "SeverityUnchangedCount",
    };
};
