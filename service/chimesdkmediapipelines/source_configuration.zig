const SelectedVideoStreams = @import("selected_video_streams.zig").SelectedVideoStreams;

/// Source configuration for a specified media pipeline.
pub const SourceConfiguration = struct {
    /// The selected video streams for a specified media pipeline. The number
    /// of video streams can't exceed 25.
    selected_video_streams: ?SelectedVideoStreams = null,

    pub const json_field_names = .{
        .selected_video_streams = "SelectedVideoStreams",
    };
};
