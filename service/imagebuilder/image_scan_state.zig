const ImageScanStatus = @import("image_scan_status.zig").ImageScanStatus;

/// Shows the vulnerability scan status for a specific image, and the reason for
/// that
/// status.
pub const ImageScanState = struct {
    /// The reason for the scan status for the image.
    reason: ?[]const u8 = null,

    /// The current state of vulnerability scans for the image. The scan starts as
    /// `PENDING` and moves through `SCANNING` and
    /// `COLLECTING` to `COMPLETED`. Image Builder sets the status to
    /// `ABANDONED` if the image reaches a terminal state before the scan
    /// finding collection completes. A scan can also end as `FAILED` or
    /// `TIMED_OUT`.
    status: ?ImageScanStatus = null,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
