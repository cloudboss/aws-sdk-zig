/// Includes counts by severity level for medium severity and higher level
/// findings, plus a total
/// for all of the findings for the specified filter.
pub const SeverityCounts = struct {
    /// The total number of findings across all severity levels for the specified
    /// filter.
    all: ?i64,

    /// The number of critical severity findings for the specified filter.
    critical: ?i64,

    /// The number of high severity findings for the specified filter.
    high: ?i64,

    /// The number of medium severity findings for the specified filter.
    medium: ?i64,

    pub const json_field_names = .{
        .all = "all",
        .critical = "critical",
        .high = "high",
        .medium = "medium",
    };
};
