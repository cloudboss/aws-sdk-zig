const ScanType = @import("scan_type.zig").ScanType;
const ResourceScanStatus = @import("resource_scan_status.zig").ResourceScanStatus;

/// A summary of the resource scan. This is returned by the `ListResourceScan`
/// API
/// action.
pub const ResourceScanSummary = struct {
    /// The time that the resource scan was finished.
    end_time: ?i64,

    /// The percentage of the resource scan that has been completed.
    percentage_completed: ?f64,

    /// The Amazon Resource Name (ARN) of the resource scan.
    resource_scan_id: ?[]const u8,

    /// The scan type that has been completed.
    scan_type: ?ScanType,

    /// The time that the resource scan was started.
    start_time: ?i64,

    /// Status of the resource scan.
    ///
    /// **
    ///
    /// IN_PROGRESS
    ///
    /// **
    ///
    /// The resource scan is still in progress.
    ///
    /// **
    ///
    /// COMPLETE
    ///
    /// **
    ///
    /// The resource scan is complete.
    ///
    /// **
    ///
    /// EXPIRED
    ///
    /// **
    ///
    /// The resource scan has expired.
    ///
    /// **
    ///
    /// FAILED
    ///
    /// **
    ///
    /// The resource scan has failed.
    status: ?ResourceScanStatus,

    /// The reason for the resource scan status, providing more information if a
    /// failure
    /// happened.
    status_reason: ?[]const u8,
};
