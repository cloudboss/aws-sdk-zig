/// A suggested action that opens a URL in the recipient's browser or an in-app
/// webview.
pub const RcsOpenUrlAction = struct {
    /// How to open the URL. BROWSER opens in the device's default browser. WEBVIEW
    /// opens in an in-app webview.
    application: ?[]const u8 = null,

    /// The postback data sent to your webhook when the user taps this action.
    /// Maximum 2048 characters.
    postback_data: []const u8,

    /// The display text of the action. Maximum 25 characters.
    text: []const u8,

    /// The URL to open. Must start with https://. Maximum 2048 characters.
    url: []const u8,

    /// The display mode of the webview. Valid values are FULL, HALF, and TALL. Only
    /// applicable when Application is WEBVIEW.
    webview_view_mode: ?[]const u8 = null,

    pub const json_field_names = .{
        .application = "Application",
        .postback_data = "PostbackData",
        .text = "Text",
        .url = "Url",
        .webview_view_mode = "WebviewViewMode",
    };
};
