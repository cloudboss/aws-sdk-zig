/// H264 Quality Level
pub const H264QualityLevel = enum {
    enhanced_quality,
    standard_quality,

    pub const json_field_names = .{
        .enhanced_quality = "ENHANCED_QUALITY",
        .standard_quality = "STANDARD_QUALITY",
    };
};
