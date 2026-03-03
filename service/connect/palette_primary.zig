/// Contains primary color configuration for a workspace theme.
pub const PalettePrimary = struct {
    /// The primary color used for active states.
    active: ?[]const u8 = null,

    /// The text color that contrasts with the primary color for readability.
    contrast_text: ?[]const u8 = null,

    /// The default primary color used throughout the workspace.
    default: ?[]const u8 = null,

    pub const json_field_names = .{
        .active = "Active",
        .contrast_text = "ContrastText",
        .default = "Default",
    };
};
