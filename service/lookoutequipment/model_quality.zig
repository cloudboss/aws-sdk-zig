pub const ModelQuality = enum {
    quality_threshold_met,
    cannot_determine_quality,
    poor_quality_detected,

    pub const json_field_names = .{
        .quality_threshold_met = "QUALITY_THRESHOLD_MET",
        .cannot_determine_quality = "CANNOT_DETERMINE_QUALITY",
        .poor_quality_detected = "POOR_QUALITY_DETECTED",
    };
};
