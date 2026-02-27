const ImageScanStatus = @import("image_scan_status.zig").ImageScanStatus;

/// Shows the vulnerability scan status for a specific image, and the reason for
/// that
/// status.
pub const ImageScanState = struct {
    /// The reason for the scan status for the image.
    reason: ?[]const u8,

    /// The current state of vulnerability scans for the image.
    status: ?ImageScanStatus,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
