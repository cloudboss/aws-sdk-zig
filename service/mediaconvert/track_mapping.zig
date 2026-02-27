/// An array containing track mapping information.
pub const TrackMapping = struct {
    /// The index numbers of the audio tracks in your media file.
    audio_track_indexes: ?[]const i32,

    /// The index numbers of the data tracks in your media file.
    data_track_indexes: ?[]const i32,

    /// The index numbers of the video tracks in your media file.
    video_track_indexes: ?[]const i32,

    pub const json_field_names = .{
        .audio_track_indexes = "AudioTrackIndexes",
        .data_track_indexes = "DataTrackIndexes",
        .video_track_indexes = "VideoTrackIndexes",
    };
};
