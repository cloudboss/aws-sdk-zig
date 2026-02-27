const ScanStatus = @import("scan_status.zig").ScanStatus;

/// Contains information about on-demand scans performed on a code repository.
pub const CodeRepositoryOnDemandScan = struct {
    /// The timestamp when the last on-demand scan was performed.
    last_scan_at: ?i64,

    /// The ID of the last commit that was scanned during an on-demand scan.
    last_scanned_commit_id: ?[]const u8,

    scan_status: ?ScanStatus,

    pub const json_field_names = .{
        .last_scan_at = "lastScanAt",
        .last_scanned_commit_id = "lastScannedCommitId",
        .scan_status = "scanStatus",
    };
};
