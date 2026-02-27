/// A numeric value corresponding to the severity of a finding, such as the
/// number of open findings or the average time it takes to close findings of a
/// given severity.
pub const FindingMetricsValuePerSeverity = struct {
    /// A numeric value corresponding to a critical finding.
    critical: ?f64,

    /// A numeric value corresponding to a high severity finding.
    high: ?f64,

    /// A numeric value corresponding to an informational finding.
    info: ?f64,

    /// A numeric value corresponding to a low severity finding.
    low: ?f64,

    /// A numeric value corresponding to a medium severity finding.
    medium: ?f64,

    pub const json_field_names = .{
        .critical = "critical",
        .high = "high",
        .info = "info",
        .low = "low",
        .medium = "medium",
    };
};
