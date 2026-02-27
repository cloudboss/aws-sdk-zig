/// When set to VIDEO_AND_FIXED_INTERVALS, audio EBP markers will be added to
/// partitions 3 and 4. The interval between these additional markers will be
/// fixed, and will be slightly shorter than the video EBP marker interval. When
/// set to VIDEO_INTERVAL, these additional markers will not be inserted. Only
/// applicable when EBP segmentation markers are is selected
/// (segmentationMarkers is EBP or EBP_LEGACY).
pub const M2tsEbpAudioInterval = enum {
    video_and_fixed_intervals,
    video_interval,

    pub const json_field_names = .{
        .video_and_fixed_intervals = "VIDEO_AND_FIXED_INTERVALS",
        .video_interval = "VIDEO_INTERVAL",
    };
};
