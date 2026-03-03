const VideoOverlayUnit = @import("video_overlay_unit.zig").VideoOverlayUnit;

/// position of video overlay
pub const VideoOverlayPosition = struct {
    /// To scale your video overlay to the same height as the base input video:
    /// Leave blank. To scale the height of your video overlay to a different
    /// height: Enter an integer representing the Unit type that you choose, either
    /// Pixels or Percentage. For example, when you enter 360 and choose Pixels,
    /// your video overlay will be rendered with a height of 360. When you enter 50,
    /// choose Percentage, and your overlay's source has a height of 1080, your
    /// video overlay will be rendered with a height of 540. To scale your overlay
    /// to a specific height while automatically maintaining its original aspect
    /// ratio, enter a value for Height and leave Width blank.
    height: ?i32 = null,

    /// Use Opacity to specify how much of the underlying video shows through the
    /// overlay video. 0 is transparent and 100 is fully opaque. Default is 100.
    opacity: ?i32 = null,

    /// Specify the Unit type to use when you enter a value for X position, Y
    /// position, Width, or Height. You can choose Pixels or Percentage. Leave blank
    /// to use the default value, Pixels.
    unit: ?VideoOverlayUnit = null,

    /// To scale your video overlay to the same width as the base input video: Leave
    /// blank. To scale the width of your video overlay to a different width: Enter
    /// an integer representing the Unit type that you choose, either Pixels or
    /// Percentage. For example, when you enter 640 and choose Pixels, your video
    /// overlay will scale to a height of 640 pixels. When you enter 50, choose
    /// Percentage, and your overlay's source has a width of 1920, your video
    /// overlay will scale to a width of 960. To scale your overlay to a specific
    /// width while automatically maintaining its original aspect ratio, enter a
    /// value for Width and leave Height blank.
    width: ?i32 = null,

    /// To position the left edge of your video overlay along the left edge of the
    /// base input video's frame: Keep blank, or enter 0. To position the left edge
    /// of your video overlay to the right, relative to the left edge of the base
    /// input video's frame: Enter an integer representing the Unit type that you
    /// choose, either Pixels or Percentage. For example, when you enter 10 and
    /// choose Pixels, your video overlay will be positioned 10 pixels from the left
    /// edge of the base input video's frame. When you enter 10, choose Percentage,
    /// and your base input video is 1920x1080, your video overlay will be
    /// positioned 192 pixels from the left edge of the base input video's frame.
    x_position: ?i32 = null,

    /// To position the top edge of your video overlay along the top edge of the
    /// base input video's frame: Keep blank, or enter 0. To position the top edge
    /// of your video overlay down, relative to the top edge of the base input
    /// video's frame: Enter an integer representing the Unit type that you choose,
    /// either Pixels or Percentage. For example, when you enter 10 and choose
    /// Pixels, your video overlay will be positioned 10 pixels from the top edge of
    /// the base input video's frame. When you enter 10, choose Percentage, and your
    /// underlying video is 1920x1080, your video overlay will be positioned 108
    /// pixels from the top edge of the base input video's frame.
    y_position: ?i32 = null,

    pub const json_field_names = .{
        .height = "Height",
        .opacity = "Opacity",
        .unit = "Unit",
        .width = "Width",
        .x_position = "XPosition",
        .y_position = "YPosition",
    };
};
