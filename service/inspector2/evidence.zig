/// Details of the evidence for a vulnerability identified in a finding.
pub const Evidence = struct {
    /// The evidence details.
    evidence_detail: ?[]const u8 = null,

    /// The evidence rule.
    evidence_rule: ?[]const u8 = null,

    /// The evidence severity.
    severity: ?[]const u8 = null,

    pub const json_field_names = .{
        .evidence_detail = "evidenceDetail",
        .evidence_rule = "evidenceRule",
        .severity = "severity",
    };
};
