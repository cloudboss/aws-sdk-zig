const ScanFinding = @import("scan_finding.zig").ScanFinding;
const MalwareScanner = @import("malware_scanner.zig").MalwareScanner;
const ScanJobState = @import("scan_job_state.zig").ScanJobState;

/// Contains the results of a security scan, including scanner information, scan
/// state, and any findings discovered.
pub const ScanResult = struct {
    /// An array of findings discovered during the scan.
    findings: ?[]const ScanFinding = null,

    /// The timestamp of when the last scan was performed, in Unix format and
    /// Coordinated Universal Time (UTC).
    last_scan_timestamp: ?i64 = null,

    /// The malware scanner used to perform the scan. Currently only `GUARDDUTY` is
    /// supported.
    malware_scanner: ?MalwareScanner = null,

    /// The final state of the scan job.
    ///
    /// Valid values: `COMPLETED` | `FAILED` | `CANCELED`.
    scan_job_state: ?ScanJobState = null,

    pub const json_field_names = .{
        .findings = "Findings",
        .last_scan_timestamp = "LastScanTimestamp",
        .malware_scanner = "MalwareScanner",
        .scan_job_state = "ScanJobState",
    };
};
