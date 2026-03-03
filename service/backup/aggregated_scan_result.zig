const ScanFinding = @import("scan_finding.zig").ScanFinding;

/// Contains aggregated scan results across multiple scan operations, providing
/// a summary of scan status and findings.
pub const AggregatedScanResult = struct {
    /// A Boolean value indicating whether any of the aggregated scans failed.
    failed_scan: ?bool = null,

    /// An array of findings discovered across all aggregated scans.
    findings: ?[]const ScanFinding = null,

    /// The timestamp when the aggregated scan result was last computed, in Unix
    /// format and Coordinated Universal Time (UTC).
    last_computed: ?i64 = null,

    pub const json_field_names = .{
        .failed_scan = "FailedScan",
        .findings = "Findings",
        .last_computed = "LastComputed",
    };
};
