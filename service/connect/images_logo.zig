/// Contains logo image configuration for workspace themes.
pub const ImagesLogo = struct {
    /// The default logo image displayed in the workspace.
    default: ?[]const u8 = null,

    /// The favicon image displayed in the browser tab.
    favicon: ?[]const u8 = null,

    pub const json_field_names = .{
        .default = "Default",
        .favicon = "Favicon",
    };
};
