/// A structure representing a screenshot that is used as a baseline during
/// visual monitoring comparisons made by the canary.
pub const BaseScreenshot = struct {
    /// Coordinates that define the part of a screen to ignore during screenshot
    /// comparisons. To obtain the
    /// coordinates to use here, use the
    /// CloudWatch console to draw the boundaries on the screen. For more
    /// information, see
    /// [
    /// Editing or deleting a
    /// canary](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/synthetics_canaries_deletion.html)
    ignore_coordinates: ?[]const []const u8 = null,

    /// The name of the screenshot. This is generated the first time the canary is
    /// run after the `UpdateCanary` operation that
    /// specified for this canary to perform visual monitoring.
    screenshot_name: []const u8,

    pub const json_field_names = .{
        .ignore_coordinates = "IgnoreCoordinates",
        .screenshot_name = "ScreenshotName",
    };
};
