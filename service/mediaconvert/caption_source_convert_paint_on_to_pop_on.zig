/// Choose the presentation style of your input SCC captions. To use the same
/// presentation style as your input: Keep the default value, Disabled. To
/// convert paint-on captions to pop-on: Choose Enabled. We also recommend that
/// you choose Enabled if you notice additional repeated lines in your output
/// captions.
pub const CaptionSourceConvertPaintOnToPopOn = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
