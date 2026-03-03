const BaseScreenshot = @import("base_screenshot.zig").BaseScreenshot;
const BrowserType = @import("browser_type.zig").BrowserType;

/// An object that specifies what screenshots to use as a baseline for visual
/// monitoring by this canary. It can
/// optionally also specify parts of the screenshots to ignore during the visual
/// monitoring comparison.
///
/// Visual monitoring is supported only on canaries running the
/// **syn-puppeteer-node-3.2**
/// runtime or later. For more information, see [
/// Visual
/// monitoring](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Library_SyntheticsLogger_VisualTesting.html) and [
/// Visual monitoring
/// blueprint](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_Blueprints_VisualTesting.html)
pub const VisualReferenceInput = struct {
    /// Specifies which canary run to use the screenshots from as the baseline for
    /// future visual monitoring with this canary. Valid values are
    /// `nextrun` to use the screenshots from the next run after this update is
    /// made, `lastrun` to use the screenshots from the most recent run
    /// before this update was made, or the value of `Id` in the [
    /// CanaryRun](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_CanaryRun.html) from a run of this a canary in the past 31 days. If you specify the `Id` of a canary run older than 31 days,
    /// the operation returns a 400 validation exception error..
    base_canary_run_id: []const u8,

    /// An array of screenshots that will be used as the baseline for visual
    /// monitoring in future runs of this canary. If there is a screenshot that you
    /// don't want to be used for
    /// visual monitoring, remove it from this array.
    base_screenshots: ?[]const BaseScreenshot = null,

    /// The browser type associated with this visual reference.
    browser_type: ?BrowserType = null,

    pub const json_field_names = .{
        .base_canary_run_id = "BaseCanaryRunId",
        .base_screenshots = "BaseScreenshots",
        .browser_type = "BrowserType",
    };
};
