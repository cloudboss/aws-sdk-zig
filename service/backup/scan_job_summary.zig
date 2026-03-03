const MalwareScanner = @import("malware_scanner.zig").MalwareScanner;
const ScanResultStatus = @import("scan_result_status.zig").ScanResultStatus;
const ScanJobStatus = @import("scan_job_status.zig").ScanJobStatus;

/// Contains summary information about scan jobs, including counts and metadata
/// for a specific time period and criteria.
pub const ScanJobSummary = struct {
    /// The account ID that owns the scan jobs included in this summary.
    account_id: ?[]const u8 = null,

    /// The number of scan jobs that match the specified criteria.
    count: i32 = 0,

    /// The value of time in number format of a job end time.
    ///
    /// This value is the time in Unix format, Coordinated Universal Time (UTC), and
    /// accurate to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    end_time: ?i64 = null,

    /// Specifies the malware scanner used during the scan job. Currently only
    /// supports `GUARDDUTY`.
    malware_scanner: ?MalwareScanner = null,

    /// The Amazon Web Services Region where the scan jobs were executed.
    region: ?[]const u8 = null,

    /// The type of Amazon Web Services resource for the scan jobs included in this
    /// summary.
    resource_type: ?[]const u8 = null,

    /// The scan result status for the scan jobs included in this summary.
    ///
    /// Valid values: `THREATS_FOUND` | `NO_THREATS_FOUND`.
    scan_result_status: ?ScanResultStatus = null,

    /// The value of time in number format of a job start time.
    ///
    /// This value is the time in Unix format, Coordinated Universal Time (UTC), and
    /// accurate to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    start_time: ?i64 = null,

    /// The state of the scan jobs included in this summary.
    ///
    /// Valid values: `CREATED` | `RUNNING` | `COMPLETED` |
    /// `COMPLETED_WITH_ISSUES` | `FAILED` | `CANCELED`.
    state: ?ScanJobStatus = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .count = "Count",
        .end_time = "EndTime",
        .malware_scanner = "MalwareScanner",
        .region = "Region",
        .resource_type = "ResourceType",
        .scan_result_status = "ScanResultStatus",
        .start_time = "StartTime",
        .state = "State",
    };
};
