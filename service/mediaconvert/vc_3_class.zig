/// Specify the VC3 class to choose the quality characteristics for this output.
/// VC3 class, together with the settings Framerate (framerateNumerator and
/// framerateDenominator) and Resolution (height and width), determine your
/// output bitrate. For example, say that your video resolution is 1920x1080 and
/// your framerate is 29.97. Then Class 145 gives you an output with a bitrate
/// of approximately 145 Mbps and Class 220 gives you and output with a bitrate
/// of approximately 220 Mbps. VC3 class also specifies the color bit depth of
/// your output.
pub const Vc3Class = enum {
    class_145_8_bit,
    class_220_8_bit,
    class_220_10_bit,

    pub const json_field_names = .{
        .class_145_8_bit = "CLASS_145_8BIT",
        .class_220_8_bit = "CLASS_220_8BIT",
        .class_220_10_bit = "CLASS_220_10BIT",
    };
};
