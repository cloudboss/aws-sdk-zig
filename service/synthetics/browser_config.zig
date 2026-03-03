const BrowserType = @import("browser_type.zig").BrowserType;

/// A structure that specifies the browser type to use for a canary run.
pub const BrowserConfig = struct {
    /// The browser type associated with this browser configuration.
    browser_type: ?BrowserType = null,

    pub const json_field_names = .{
        .browser_type = "BrowserType",
    };
};
