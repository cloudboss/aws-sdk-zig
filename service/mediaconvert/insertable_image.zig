/// These settings apply to a specific graphic overlay. You can include multiple
/// overlays in your job.
pub const InsertableImage = struct {
    /// Specify the time, in milliseconds, for the image to remain on the output
    /// video. This duration includes fade-in time but not fade-out time.
    duration: ?i32,

    /// Specify the length of time, in milliseconds, between the Start time that you
    /// specify for the image insertion and the time that the image appears at full
    /// opacity. Full opacity is the level that you specify for the opacity setting.
    /// If you don't specify a value for Fade-in, the image will appear abruptly at
    /// the overlay start time.
    fade_in: ?i32,

    /// Specify the length of time, in milliseconds, between the end of the time
    /// that you have specified for the image overlay Duration and when the overlaid
    /// image has faded to total transparency. If you don't specify a value for
    /// Fade-out, the image will disappear abruptly at the end of the inserted image
    /// duration.
    fade_out: ?i32,

    /// Specify the height of the inserted image in pixels. If you specify a value
    /// that's larger than the video resolution height, the service will crop your
    /// overlaid image to fit. To use the native height of the image, keep this
    /// setting blank.
    height: ?i32,

    /// Specify the HTTP, HTTPS, or Amazon S3 location of the image that you want to
    /// overlay on the video. Use a PNG or TGA file.
    image_inserter_input: ?[]const u8,

    /// Specify the distance, in pixels, between the inserted image and the left
    /// edge of the video frame. Required for any image overlay that you specify.
    image_x: ?i32,

    /// Specify the distance, in pixels, between the overlaid image and the top edge
    /// of the video frame. Required for any image overlay that you specify.
    image_y: ?i32,

    /// Specify how overlapping inserted images appear. Images with higher values
    /// for Layer appear on top of images with lower values for Layer.
    layer: ?i32,

    /// Use Opacity to specify how much of the underlying video shows through the
    /// inserted image. 0 is transparent and 100 is fully opaque. Default is 50.
    opacity: ?i32,

    /// Specify the timecode of the frame that you want the overlay to first appear
    /// on. This must be in timecode (HH:MM:SS:FF or HH:MM:SS;FF) format. Remember
    /// to take into account your timecode source settings.
    start_time: ?[]const u8,

    /// Specify the width of the inserted image in pixels. If you specify a value
    /// that's larger than the video resolution width, the service will crop your
    /// overlaid image to fit. To use the native width of the image, keep this
    /// setting blank.
    width: ?i32,

    pub const json_field_names = .{
        .duration = "Duration",
        .fade_in = "FadeIn",
        .fade_out = "FadeOut",
        .height = "Height",
        .image_inserter_input = "ImageInserterInput",
        .image_x = "ImageX",
        .image_y = "ImageY",
        .layer = "Layer",
        .opacity = "Opacity",
        .start_time = "StartTime",
        .width = "Width",
    };
};
