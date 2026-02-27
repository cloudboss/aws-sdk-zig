const AttendeeFeatures = @import("attendee_features.zig").AttendeeFeatures;
const AudioFeatures = @import("audio_features.zig").AudioFeatures;
const ContentFeatures = @import("content_features.zig").ContentFeatures;
const VideoFeatures = @import("video_features.zig").VideoFeatures;

/// The configuration settings of the features available to a meeting.
pub const MeetingFeaturesConfiguration = struct {
    /// The configuration settings for the attendee features available to a meeting.
    attendee: ?AttendeeFeatures,

    /// The configuration settings for the audio features available to a meeting.
    audio: ?AudioFeatures,

    /// The configuration settings for the content features available to a meeting.
    content: ?ContentFeatures,

    /// The configuration settings for the video features available to a meeting.
    video: ?VideoFeatures,

    pub const json_field_names = .{
        .attendee = "Attendee",
        .audio = "Audio",
        .content = "Content",
        .video = "Video",
    };
};
