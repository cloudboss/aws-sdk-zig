/// An object representing a configuration of participant HLS recordings for
/// individual participant recording.
pub const ParticipantRecordingHlsConfiguration = struct {
    /// Defines the target duration for recorded segments generated when recording a
    /// stage participant.
    /// Segments may have durations longer than the specified value when needed to
    /// ensure each segment begins with a keyframe.
    /// Default: 6.
    target_segment_duration_seconds: ?i32 = null,

    pub const json_field_names = .{
        .target_segment_duration_seconds = "targetSegmentDurationSeconds",
    };
};
