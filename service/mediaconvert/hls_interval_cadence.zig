/// The cadence MediaConvert follows for generating thumbnails. If set to
/// FOLLOW_IFRAME, MediaConvert generates thumbnails for each IDR frame in the
/// output (matching the GOP cadence). If set to FOLLOW_CUSTOM, MediaConvert
/// generates thumbnails according to the interval you specify in
/// thumbnailInterval.
pub const HlsIntervalCadence = enum {
    follow_iframe,
    follow_custom,

    pub const json_field_names = .{
        .follow_iframe = "FOLLOW_IFRAME",
        .follow_custom = "FOLLOW_CUSTOM",
    };
};
