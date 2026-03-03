const ScanState = @import("scan_state.zig").ScanState;

/// Information about a scan.
pub const ScanSummary = struct {
    /// The time when the scan was created.
    created_at: i64,

    /// The identifier for the scan run.
    run_id: []const u8,

    /// The name of the scan.
    scan_name: []const u8,

    /// The ARN for the scan name.
    scan_name_arn: ?[]const u8 = null,

    /// The state of the scan. A scan can be `In Progress`, `Complete`, or `Failed`.
    scan_state: ScanState,

    /// The time the scan was last updated. A scan is updated when it is re-run.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .run_id = "runId",
        .scan_name = "scanName",
        .scan_name_arn = "scanNameArn",
        .scan_state = "scanState",
        .updated_at = "updatedAt",
    };
};
