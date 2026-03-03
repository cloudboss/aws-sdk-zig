/// Determines the font settings.
pub const Font = struct {
    /// Determines the font family settings.
    font_family: ?[]const u8 = null,

    pub const json_field_names = .{
        .font_family = "FontFamily",
    };
};
