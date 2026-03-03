/// Contains color configuration for canvas elements in a workspace theme.
pub const PaletteCanvas = struct {
    /// The background color for active elements.
    active_background: ?[]const u8 = null,

    /// The background color for container elements.
    container_background: ?[]const u8 = null,

    /// The background color for page elements.
    page_background: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_background = "ActiveBackground",
        .container_background = "ContainerBackground",
        .page_background = "PageBackground",
    };
};
