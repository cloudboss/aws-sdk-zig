/// The color palette.
pub const Palette = struct {
    /// The background color.
    background: ?[]const u8 = null,

    /// The foreground color.
    foreground: ?[]const u8 = null,

    pub const json_field_names = .{
        .background = "Background",
        .foreground = "Foreground",
    };
};
