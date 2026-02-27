/// Contains counts of findings grouped by severity level for trend analysis.
pub const SeverityTrendsCount = struct {
    /// The count of findings with Critical severity level at this point in the
    /// trend timeline.
    critical: i64,

    /// The count of findings with Fatal severity level at this point in the trend
    /// timeline.
    fatal: i64,

    /// The count of findings with High severity level at this point in the trend
    /// timeline.
    high: i64,

    /// The count of findings with Informational severity level at this point in the
    /// trend timeline.
    informational: i64,

    /// The count of findings with Low severity level at this point in the trend
    /// timeline.
    low: i64,

    /// The count of findings with Medium severity level at this point in the trend
    /// timeline.
    medium: i64,

    /// The count of findings with severity levels not fitting into the standard
    /// categories at this point in the trend timeline.
    other: i64,

    /// The count of findings with Unknown severity level at this point in the trend
    /// timeline.
    unknown: i64,

    pub const json_field_names = .{
        .critical = "Critical",
        .fatal = "Fatal",
        .high = "High",
        .informational = "Informational",
        .low = "Low",
        .medium = "Medium",
        .other = "Other",
        .unknown = "Unknown",
    };
};
