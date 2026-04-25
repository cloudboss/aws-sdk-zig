const ScreenshotFormat = @import("screenshot_format.zig").ScreenshotFormat;

/// Arguments for a screenshot action.
pub const ScreenshotArguments = struct {
    /// The image format for the screenshot. Defaults to `PNG`.
    format: ?ScreenshotFormat = null,

    pub const json_field_names = .{
        .format = "format",
    };
};
