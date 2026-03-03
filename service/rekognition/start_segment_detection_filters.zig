const StartShotDetectionFilter = @import("start_shot_detection_filter.zig").StartShotDetectionFilter;
const StartTechnicalCueDetectionFilter = @import("start_technical_cue_detection_filter.zig").StartTechnicalCueDetectionFilter;

/// Filters applied to the technical cue or shot detection segments.
/// For more information, see StartSegmentDetection.
pub const StartSegmentDetectionFilters = struct {
    /// Filters that are specific to shot detections.
    shot_filter: ?StartShotDetectionFilter = null,

    /// Filters that are specific to technical cues.
    technical_cue_filter: ?StartTechnicalCueDetectionFilter = null,

    pub const json_field_names = .{
        .shot_filter = "ShotFilter",
        .technical_cue_filter = "TechnicalCueFilter",
    };
};
