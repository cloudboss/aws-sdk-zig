/// Enable this setting to insert I-frames at scene changes that the service
/// automatically detects. This improves video quality and is enabled by
/// default. If this output uses QVBR, choose Transition detection for further
/// video quality improvement. For more information about QVBR, see
/// https://docs.aws.amazon.com/console/mediaconvert/cbr-vbr-qvbr.
pub const H265SceneChangeDetect = enum {
    disabled,
    enabled,
    transition_detection,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .transition_detection = "TRANSITION_DETECTION",
    };
};
