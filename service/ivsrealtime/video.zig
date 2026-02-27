/// Settings for video.
pub const Video = struct {
    /// Bitrate for generated output, in bps. Default: 2500000.
    bitrate: ?i32,

    /// Video frame rate, in fps. Default: 30.
    framerate: ?f32,

    /// Video-resolution height. This must be an even number. Note that the maximum
    /// value is
    /// determined by `width` times `height`, such that the maximum total
    /// pixels is 2073600 (1920x1080 or 1080x1920). Default: 720.
    height: ?i32,

    /// Video-resolution width. This must be an even number. Note that the maximum
    /// value is
    /// determined by `width` times `height`, such that the maximum total
    /// pixels is 2073600 (1920x1080 or 1080x1920). Default: 1280.
    width: ?i32,

    pub const json_field_names = .{
        .bitrate = "bitrate",
        .framerate = "framerate",
        .height = "height",
        .width = "width",
    };
};
