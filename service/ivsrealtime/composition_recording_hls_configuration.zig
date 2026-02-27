/// An object representing a configuration of HLS recordings for server-side
/// composition.
pub const CompositionRecordingHlsConfiguration = struct {
    /// Defines the target duration for recorded segments generated when using
    /// composite recording. Default: 2.
    target_segment_duration_seconds: ?i32,

    pub const json_field_names = .{
        .target_segment_duration_seconds = "targetSegmentDurationSeconds",
    };
};
