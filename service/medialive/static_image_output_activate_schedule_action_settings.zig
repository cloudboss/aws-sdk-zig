const InputLocation = @import("input_location.zig").InputLocation;

/// Settings for the action to activate a static image.
pub const StaticImageOutputActivateScheduleActionSettings = struct {
    /// The duration in milliseconds for the image to remain on the video. If
    /// omitted or set to 0 the duration is unlimited and the image will remain
    /// until it is explicitly deactivated.
    duration: ?i32,

    /// The time in milliseconds for the image to fade in. The fade-in starts at the
    /// start time of the overlay. Default is 0 (no fade-in).
    fade_in: ?i32,

    /// Applies only if a duration is specified. The time in milliseconds for the
    /// image to fade out. The fade-out starts when the duration time is hit, so it
    /// effectively extends the duration. Default is 0 (no fade-out).
    fade_out: ?i32,

    /// The height of the image when inserted into the video, in pixels. The overlay
    /// will be scaled up or down to the specified height. Leave blank to use the
    /// native height of the overlay.
    height: ?i32,

    /// The location and filename of the image file to overlay on the video. The
    /// file must be a 32-bit BMP, PNG, or TGA file, and must not be larger (in
    /// pixels) than the input video.
    image: InputLocation,

    /// Placement of the left edge of the overlay relative to the left edge of the
    /// video frame, in pixels. 0 (the default) is the left edge of the frame. If
    /// the placement causes the overlay to extend beyond the right edge of the
    /// underlying video, then the overlay is cropped on the right.
    image_x: ?i32,

    /// Placement of the top edge of the overlay relative to the top edge of the
    /// video frame, in pixels. 0 (the default) is the top edge of the frame. If the
    /// placement causes the overlay to extend beyond the bottom edge of the
    /// underlying video, then the overlay is cropped on the bottom.
    image_y: ?i32,

    /// The number of the layer, 0 to 7. There are 8 layers that can be overlaid on
    /// the video, each layer with a different image. The layers are in Z order,
    /// which means that overlays with higher values of layer are inserted on top of
    /// overlays with lower values of layer. Default is 0.
    layer: ?i32,

    /// Opacity of image where 0 is transparent and 100 is fully opaque. Default is
    /// 100.
    opacity: ?i32,

    /// The name(s) of the output(s) the activation should apply to.
    output_names: []const []const u8,

    /// The width of the image when inserted into the video, in pixels. The overlay
    /// will be scaled up or down to the specified width. Leave blank to use the
    /// native width of the overlay.
    width: ?i32,

    pub const json_field_names = .{
        .duration = "Duration",
        .fade_in = "FadeIn",
        .fade_out = "FadeOut",
        .height = "Height",
        .image = "Image",
        .image_x = "ImageX",
        .image_y = "ImageY",
        .layer = "Layer",
        .opacity = "Opacity",
        .output_names = "OutputNames",
        .width = "Width",
    };
};
