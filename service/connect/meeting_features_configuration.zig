const AudioFeatures = @import("audio_features.zig").AudioFeatures;

/// The configuration settings of the features available to a meeting.
pub const MeetingFeaturesConfiguration = struct {
    /// The configuration settings for the audio features available to a meeting.
    audio: ?AudioFeatures,

    pub const json_field_names = .{
        .audio = "Audio",
    };
};
