const TimecodeBurninFontSize = @import("timecode_burnin_font_size.zig").TimecodeBurninFontSize;
const TimecodeBurninPosition = @import("timecode_burnin_position.zig").TimecodeBurninPosition;

/// Timecode Burnin Settings
pub const TimecodeBurninSettings = struct {
    /// Choose a timecode burn-in font size
    font_size: TimecodeBurninFontSize,

    /// Choose a timecode burn-in output position
    position: TimecodeBurninPosition,

    /// Create a timecode burn-in prefix (optional)
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .font_size = "FontSize",
        .position = "Position",
        .prefix = "Prefix",
    };
};
