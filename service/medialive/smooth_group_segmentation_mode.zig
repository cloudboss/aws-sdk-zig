/// Smooth Group Segmentation Mode
pub const SmoothGroupSegmentationMode = enum {
    use_input_segmentation,
    use_segment_duration,

    pub const json_field_names = .{
        .use_input_segmentation = "USE_INPUT_SEGMENTATION",
        .use_segment_duration = "USE_SEGMENT_DURATION",
    };
};
