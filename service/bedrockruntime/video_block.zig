const VideoFormat = @import("video_format.zig").VideoFormat;
const VideoSource = @import("video_source.zig").VideoSource;

/// A video block.
pub const VideoBlock = struct {
    /// The block's format.
    format: VideoFormat,

    /// The block's source.
    source: VideoSource,

    pub const json_field_names = .{
        .format = "format",
        .source = "source",
    };
};
