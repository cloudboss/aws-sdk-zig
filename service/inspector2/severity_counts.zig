/// An object that contains the counts of aggregated finding per severity.
pub const SeverityCounts = struct {
    /// The total count of findings from all severities.
    all: ?i64,

    /// The total count of critical severity findings.
    critical: ?i64,

    /// The total count of high severity findings.
    high: ?i64,

    /// The total count of medium severity findings.
    medium: ?i64,

    pub const json_field_names = .{
        .all = "all",
        .critical = "critical",
        .high = "high",
        .medium = "medium",
    };
};
