const MeetingFeatureStatus = @import("meeting_feature_status.zig").MeetingFeatureStatus;

/// An optional category of meeting features that contains audio-specific
/// configurations, such as operating parameters for Amazon Voice Focus.
pub const AudioFeatures = struct {
    /// Makes echo reduction available to clients who connect to the meeting.
    echo_reduction: ?MeetingFeatureStatus = null,

    pub const json_field_names = .{
        .echo_reduction = "EchoReduction",
    };
};
