const PortalTheme = @import("portal_theme.zig").PortalTheme;

/// Contains the content that is visible to portal consumers including the
/// themes, display names, and description.
pub const PortalContent = struct {
    /// A description of the portal.
    description: ?[]const u8 = null,

    /// The display name for the portal.
    display_name: []const u8,

    /// The theme for the portal.
    theme: PortalTheme,

    pub const json_field_names = .{
        .description = "Description",
        .display_name = "DisplayName",
        .theme = "Theme",
    };
};
