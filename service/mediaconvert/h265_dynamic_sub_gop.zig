/// Choose Adaptive to improve subjective video quality for high-motion content.
/// This will cause the service to use fewer B-frames (which infer information
/// based on other frames) for high-motion portions of the video and more
/// B-frames for low-motion portions. The maximum number of B-frames is limited
/// by the value you provide for the setting B frames between reference frames.
pub const H265DynamicSubGop = enum {
    adaptive,
    static,

    pub const json_field_names = .{
        .adaptive = "ADAPTIVE",
        .static = "STATIC",
    };
};
