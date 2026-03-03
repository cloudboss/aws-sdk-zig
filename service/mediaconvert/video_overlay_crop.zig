const VideoOverlayUnit = @import("video_overlay_unit.zig").VideoOverlayUnit;

/// Specify a rectangle of content to crop and use from your video overlay's
/// input video. When you do, MediaConvert uses the cropped dimensions that you
/// specify under X offset, Y offset, Width, and Height.
pub const VideoOverlayCrop = struct {
    /// Specify the height of the video overlay cropping rectangle. To use the same
    /// height as your overlay input video: Keep blank, or enter 0. To specify a
    /// different height for the cropping rectangle: Enter an integer representing
    /// the Unit type that you choose, either Pixels or Percentage. For example,
    /// when you enter 100 and choose Pixels, the cropping rectangle will be 100
    /// pixels high. When you enter 10, choose Percentage, and your overlay input
    /// video is 1920x1080, the cropping rectangle will be 108 pixels high.
    height: ?i32 = null,

    /// Specify the Unit type to use when you enter a value for X position, Y
    /// position, Width, or Height. You can choose Pixels or Percentage. Leave blank
    /// to use the default value, Pixels.
    unit: ?VideoOverlayUnit = null,

    /// Specify the width of the video overlay cropping rectangle. To use the same
    /// width as your overlay input video: Keep blank, or enter 0. To specify a
    /// different width for the cropping rectangle: Enter an integer representing
    /// the Unit type that you choose, either Pixels or Percentage. For example,
    /// when you enter 100 and choose Pixels, the cropping rectangle will be 100
    /// pixels wide. When you enter 10, choose Percentage, and your overlay input
    /// video is 1920x1080, the cropping rectangle will be 192 pixels wide.
    width: ?i32 = null,

    /// Specify the distance between the cropping rectangle and the left edge of
    /// your overlay video's frame. To position the cropping rectangle along the
    /// left edge: Keep blank, or enter 0. To position the cropping rectangle to the
    /// right, relative to the left edge of your overlay video's frame: Enter an
    /// integer representing the Unit type that you choose, either Pixels or
    /// Percentage. For example, when you enter 10 and choose Pixels, the cropping
    /// rectangle will be positioned 10 pixels from the left edge of the overlay
    /// video's frame. When you enter 10, choose Percentage, and your overlay input
    /// video is 1920x1080, the cropping rectangle will be positioned 192 pixels
    /// from the left edge of the overlay video's frame.
    x: ?i32 = null,

    /// Specify the distance between the cropping rectangle and the top edge of your
    /// overlay video's frame. To position the cropping rectangle along the top
    /// edge: Keep blank, or enter 0. To position the cropping rectangle down,
    /// relative to the top edge of your overlay video's frame: Enter an integer
    /// representing the Unit type that you choose, either Pixels or Percentage. For
    /// example, when you enter 10 and choose Pixels, the cropping rectangle will be
    /// positioned 10 pixels from the top edge of the overlay video's frame. When
    /// you enter 10, choose Percentage, and your overlay input video is 1920x1080,
    /// the cropping rectangle will be positioned 108 pixels from the top edge of
    /// the overlay video's frame.
    y: ?i32 = null,

    pub const json_field_names = .{
        .height = "Height",
        .unit = "Unit",
        .width = "Width",
        .x = "X",
        .y = "Y",
    };
};
