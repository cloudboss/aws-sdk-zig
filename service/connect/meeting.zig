const MediaPlacement = @import("media_placement.zig").MediaPlacement;
const MeetingFeaturesConfiguration = @import("meeting_features_configuration.zig").MeetingFeaturesConfiguration;

/// A meeting created using the Amazon Chime SDK.
pub const Meeting = struct {
    /// The media placement for the meeting.
    media_placement: ?MediaPlacement = null,

    /// The Amazon Web Services Region in which you create the meeting.
    media_region: ?[]const u8 = null,

    /// The configuration settings of the features available to a meeting.
    meeting_features: ?MeetingFeaturesConfiguration = null,

    /// The Amazon Chime SDK meeting ID.
    meeting_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .media_placement = "MediaPlacement",
        .media_region = "MediaRegion",
        .meeting_features = "MeetingFeatures",
        .meeting_id = "MeetingId",
    };
};
