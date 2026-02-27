/// Ignore this setting unless this input is a QuickTime animation with an alpha
/// channel. Use this setting to create separate Key and Fill outputs. In each
/// output, specify which part of the input MediaConvert uses. Leave this
/// setting at the default value DISCARD to delete the alpha channel and
/// preserve the video. Set it to REMAP_TO_LUMA to delete the video and map the
/// alpha channel to the luma channel of your outputs.
pub const AlphaBehavior = enum {
    discard,
    remap_to_luma,

    pub const json_field_names = .{
        .discard = "DISCARD",
        .remap_to_luma = "REMAP_TO_LUMA",
    };
};
