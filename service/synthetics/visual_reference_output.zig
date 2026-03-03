const BaseScreenshot = @import("base_screenshot.zig").BaseScreenshot;
const BrowserType = @import("browser_type.zig").BrowserType;

/// If this canary performs visual monitoring by comparing screenshots, this
/// structure contains the ID of the canary run that is used as the baseline for
/// screenshots, and the coordinates
/// of any parts of those screenshots that are ignored during visual monitoring
/// comparison.
///
/// Visual monitoring is supported only on canaries running the
/// **syn-puppeteer-node-3.2** runtime or later.
pub const VisualReferenceOutput = struct {
    /// The ID of the canary run that produced the baseline screenshots
    /// that are used for visual monitoring comparisons by this canary.
    base_canary_run_id: ?[]const u8 = null,

    /// An array of screenshots that are used as the baseline for comparisons during
    /// visual monitoring.
    base_screenshots: ?[]const BaseScreenshot = null,

    /// The browser type associated with this visual reference.
    browser_type: ?BrowserType = null,

    pub const json_field_names = .{
        .base_canary_run_id = "BaseCanaryRunId",
        .base_screenshots = "BaseScreenshots",
        .browser_type = "BrowserType",
    };
};
