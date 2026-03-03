const WebRTCMediaPlacement = @import("web_rtc_media_placement.zig").WebRTCMediaPlacement;
const MeetingFeaturesConfiguration = @import("meeting_features_configuration.zig").MeetingFeaturesConfiguration;

/// A meeting created using the Amazon Chime SDK.
pub const WebRTCMeeting = struct {
    /// The media placement for the meeting.
    media_placement: ?WebRTCMediaPlacement = null,

    meeting_features: ?MeetingFeaturesConfiguration = null,

    /// The Amazon Chime SDK meeting ID.
    meeting_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .media_placement = "MediaPlacement",
        .meeting_features = "MeetingFeatures",
        .meeting_id = "MeetingId",
    };
};
