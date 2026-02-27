const ScanResultStatus = @import("scan_result_status.zig").ScanResultStatus;

/// Contains information about the results of a scan job.
pub const ScanResultInfo = struct {
    /// The status of the scan results.
    ///
    /// Valid values: `THREATS_FOUND` | `NO_THREATS_FOUND`.
    scan_result_status: ScanResultStatus,

    pub const json_field_names = .{
        .scan_result_status = "ScanResultStatus",
    };
};
