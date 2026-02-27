/// Choose the loudness measurement mode for your audio content. For music or
/// advertisements: We recommend that you keep the default value, Program. For
/// speech or other content: We recommend that you choose Anchor. When you do,
/// MediaConvert optimizes the loudness of your output for clarify by applying
/// speech gates.
pub const AacLoudnessMeasurementMode = enum {
    program,
    anchor,

    pub const json_field_names = .{
        .program = "PROGRAM",
        .anchor = "ANCHOR",
    };
};
