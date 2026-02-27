const BrowserExtension = @import("browser_extension.zig").BrowserExtension;

/// The container for browser extension configuration for an Amazon Q Business
/// web experience.
pub const BrowserExtensionConfiguration = struct {
    /// Specify the browser extensions allowed for your Amazon Q web experience.
    ///
    /// * `CHROME` — Enables the extension for Chromium-based browsers (Google
    ///   Chrome, Microsoft Edge, Opera, etc.).
    /// * `FIREFOX` — Enables the extension for Mozilla Firefox.
    /// * `CHROME` and `FIREFOX` — Enable the extension for Chromium-based browsers
    ///   and Mozilla Firefox.
    enabled_browser_extensions: []const BrowserExtension,

    pub const json_field_names = .{
        .enabled_browser_extensions = "enabledBrowserExtensions",
    };
};
