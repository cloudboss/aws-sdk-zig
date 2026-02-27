/// Represents custom colors for a published portal.
pub const CustomColors = struct {
    /// Represents the accent color.
    accent_color: []const u8,

    /// Represents the background color.
    background_color: []const u8,

    /// The errorValidationColor.
    error_validation_color: []const u8,

    /// Represents the header color.
    header_color: []const u8,

    /// Represents the navigation color.
    navigation_color: []const u8,

    /// Represents the text color.
    text_color: []const u8,

    pub const json_field_names = .{
        .accent_color = "AccentColor",
        .background_color = "BackgroundColor",
        .error_validation_color = "ErrorValidationColor",
        .header_color = "HeaderColor",
        .navigation_color = "NavigationColor",
        .text_color = "TextColor",
    };
};
