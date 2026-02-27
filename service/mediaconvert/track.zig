const AudioProperties = @import("audio_properties.zig").AudioProperties;
const Codec = @import("codec.zig").Codec;
const DataProperties = @import("data_properties.zig").DataProperties;
const TrackType = @import("track_type.zig").TrackType;
const VideoProperties = @import("video_properties.zig").VideoProperties;

/// Details about each track (video, audio, or data) in the media file.
pub const Track = struct {
    /// Details about the media file's audio track.
    audio_properties: ?AudioProperties,

    /// The codec of the audio or video track, or caption format of the data track.
    codec: ?Codec,

    /// Details about the media file's data track.
    data_properties: ?DataProperties,

    /// The duration of the track, in seconds.
    duration: ?f64,

    /// The unique index number of the track, starting at 1.
    index: ?i32,

    /// The type of track: video, audio, or data.
    track_type: ?TrackType,

    /// Details about the media file's video track.
    video_properties: ?VideoProperties,

    pub const json_field_names = .{
        .audio_properties = "AudioProperties",
        .codec = "Codec",
        .data_properties = "DataProperties",
        .duration = "Duration",
        .index = "Index",
        .track_type = "TrackType",
        .video_properties = "VideoProperties",
    };
};
