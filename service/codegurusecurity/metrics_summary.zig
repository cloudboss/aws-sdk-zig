const CategoryWithFindingNum = @import("category_with_finding_num.zig").CategoryWithFindingNum;
const FindingMetricsValuePerSeverity = @import("finding_metrics_value_per_severity.zig").FindingMetricsValuePerSeverity;
const ScanNameWithFindingNum = @import("scan_name_with_finding_num.zig").ScanNameWithFindingNum;

/// A summary of metrics for an account as of a specified date.
pub const MetricsSummary = struct {
    /// A list of `CategoryWithFindingNum` objects for the top 5 finding categories
    /// with the most findings.
    categories_with_most_findings: ?[]const CategoryWithFindingNum = null,

    /// The date from which the metrics summary information was retrieved.
    date: ?i64 = null,

    /// The number of open findings of each severity.
    open_findings: ?FindingMetricsValuePerSeverity = null,

    /// A list of `ScanNameWithFindingNum` objects for the top 3 scans with the most
    /// number of open critical findings.
    scans_with_most_open_critical_findings: ?[]const ScanNameWithFindingNum = null,

    /// A list of `ScanNameWithFindingNum` objects for the top 3 scans with the most
    /// number of open findings.
    scans_with_most_open_findings: ?[]const ScanNameWithFindingNum = null,

    pub const json_field_names = .{
        .categories_with_most_findings = "categoriesWithMostFindings",
        .date = "date",
        .open_findings = "openFindings",
        .scans_with_most_open_critical_findings = "scansWithMostOpenCriticalFindings",
        .scans_with_most_open_findings = "scansWithMostOpenFindings",
    };
};
