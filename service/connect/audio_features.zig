const MeetingFeatureStatus = @import("meeting_feature_status.zig").MeetingFeatureStatus;

/// Has audio-specific configurations as the operating parameter for Echo
/// Reduction.
pub const AudioFeatures = struct {
    /// Makes echo reduction available to clients who connect to the meeting.
    echo_reduction: ?MeetingFeatureStatus,

    pub const json_field_names = .{
        .echo_reduction = "EchoReduction",
    };
};
