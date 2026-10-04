/// An object that contains the counts of aggregated finding per severity.
pub const SeverityCounts = struct {
    /// The total count of findings from all severities.
    all: ?i64 = null,

    /// The total count of critical severity findings.
    critical: ?i64 = null,

    /// The total count of high severity findings.
    high: ?i64 = null,

    /// The total count of informational severity findings.
    informational: ?i64 = null,

    /// The total count of low severity findings.
    low: ?i64 = null,

    /// The total count of medium severity findings.
    medium: ?i64 = null,

    /// The total count of untriaged findings.
    untriaged: ?i64 = null,

    pub const json_field_names = .{
        .all = "all",
        .critical = "critical",
        .high = "high",
        .informational = "informational",
        .low = "low",
        .medium = "medium",
        .untriaged = "untriaged",
    };
};
