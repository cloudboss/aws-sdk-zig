/// The configuration that defines the dimensions of a browser viewport in a
/// browser session. The viewport determines the visible area of web content and
/// affects how web pages are rendered and displayed. Proper viewport
/// configuration ensures that web content is displayed correctly for the
/// agent's browsing tasks.
pub const ViewPort = struct {
    /// The height of the viewport in pixels. This value determines the vertical
    /// dimension of the visible area. Valid values range from 600 to 1080 pixels.
    height: i32,

    /// The width of the viewport in pixels. This value determines the horizontal
    /// dimension of the visible area. Valid values range from 800 to 1920 pixels.
    width: i32,

    pub const json_field_names = .{
        .height = "height",
        .width = "width",
    };
};
