/// A structure that describes how the portal represents an application
/// provider.
pub const DisplayData = struct {
    /// The description of the application provider that appears in the portal.
    description: ?[]const u8 = null,

    /// The name of the application provider that appears in the portal.
    display_name: ?[]const u8 = null,

    /// A URL that points to an icon that represents the application provider.
    icon_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .display_name = "DisplayName",
        .icon_url = "IconUrl",
    };
};
