const FindingMetricsValuePerSeverity = @import("finding_metrics_value_per_severity.zig").FindingMetricsValuePerSeverity;

/// A summary of findings metrics for an account on a specified date.
pub const AccountFindingsMetric = struct {
    /// The number of closed findings of each severity on the specified date.
    closed_findings: ?FindingMetricsValuePerSeverity = null,

    /// The date from which the findings metrics were retrieved.
    date: ?i64 = null,

    /// The average time in days it takes to close findings of each severity as of a
    /// specified date.
    mean_time_to_close: ?FindingMetricsValuePerSeverity = null,

    /// The number of new findings of each severity on the specified date.
    new_findings: ?FindingMetricsValuePerSeverity = null,

    /// The number of open findings of each severity as of the specified date.
    open_findings: ?FindingMetricsValuePerSeverity = null,

    pub const json_field_names = .{
        .closed_findings = "closedFindings",
        .date = "date",
        .mean_time_to_close = "meanTimeToClose",
        .new_findings = "newFindings",
        .open_findings = "openFindings",
    };
};
