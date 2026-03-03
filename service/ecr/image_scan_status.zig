const ScanStatus = @import("scan_status.zig").ScanStatus;

/// The current status of an image scan.
pub const ImageScanStatus = struct {
    /// The description of the image scan status.
    description: ?[]const u8 = null,

    /// The current state of an image scan.
    status: ?ScanStatus = null,

    pub const json_field_names = .{
        .description = "description",
        .status = "status",
    };
};
