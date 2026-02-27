const CaptureMode = @import("capture_mode.zig").CaptureMode;

/// Specifies data Model Monitor will capture.
pub const CaptureOption = struct {
    /// Specify the boundary of data to capture.
    capture_mode: CaptureMode,

    pub const json_field_names = .{
        .capture_mode = "CaptureMode",
    };
};
