/// The color palette.
pub const Palette = struct {
    /// The background color.
    background: ?[]const u8,

    /// The foreground color.
    foreground: ?[]const u8,

    pub const json_field_names = .{
        .background = "Background",
        .foreground = "Foreground",
    };
};
