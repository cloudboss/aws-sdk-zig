const TimecodeBurninPosition = @import("timecode_burnin_position.zig").TimecodeBurninPosition;

/// Settings for burning the output timecode and specified prefix into the
/// output.
pub const TimecodeBurnin = struct {
    /// Use Font size to set the font size of any burned-in timecode. Valid values
    /// are 10, 16, 32, 48.
    font_size: ?i32,

    /// Use Position under Timecode burn-in to specify the location the burned-in
    /// timecode on output video.
    position: ?TimecodeBurninPosition,

    /// Use Prefix to place ASCII characters before any burned-in timecode. For
    /// example, a prefix of "EZ-" will result in the timecode "EZ-00:00:00:00".
    /// Provide either the characters themselves or the ASCII code equivalents. The
    /// supported range of characters is 0x20 through 0x7e. This includes letters,
    /// numbers, and all special characters represented on a standard English
    /// keyboard.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .font_size = "FontSize",
        .position = "Position",
        .prefix = "Prefix",
    };
};
