/// Contains logo image configuration for workspace themes.
pub const ImagesLogo = struct {
    /// The default logo image displayed in the workspace.
    default: ?[]const u8,

    /// The favicon image displayed in the browser tab.
    favicon: ?[]const u8,

    pub const json_field_names = .{
        .default = "Default",
        .favicon = "Favicon",
    };
};
