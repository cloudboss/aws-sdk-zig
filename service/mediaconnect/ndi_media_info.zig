const NdiMediaStreamInfo = @import("ndi_media_stream_info.zig").NdiMediaStreamInfo;

/// Metadata about the audio and video media that is part of the NDI® source
/// content. This includes details about the individual media streams.
pub const NdiMediaInfo = struct {
    /// A list of the individual media streams that make up the NDI source. This
    /// includes details about each stream's codec, resolution, frame rate, audio
    /// channels, and other parameters.
    streams: []const NdiMediaStreamInfo,

    pub const json_field_names = .{
        .streams = "Streams",
    };
};
