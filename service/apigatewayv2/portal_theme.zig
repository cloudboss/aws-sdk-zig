const CustomColors = @import("custom_colors.zig").CustomColors;

/// Defines the theme for a portal.
pub const PortalTheme = struct {
    /// Defines custom color values.
    custom_colors: CustomColors,

    /// The timestamp when the logo was last uploaded.
    logo_last_uploaded: ?i64,

    pub const json_field_names = .{
        .custom_colors = "CustomColors",
        .logo_last_uploaded = "LogoLastUploaded",
    };
};
