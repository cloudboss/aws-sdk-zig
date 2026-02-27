/// Specify whether this set of input captions appears in your outputs in both
/// 608 and 708 format. If you choose Upconvert, MediaConvert includes the
/// captions data in two ways: it passes the 608 data through using the 608
/// compatibility bytes fields of the 708 wrapper, and it also translates the
/// 608 data into 708.
pub const EmbeddedConvert608To708 = enum {
    upconvert,
    disabled,

    pub const json_field_names = .{
        .upconvert = "UPCONVERT",
        .disabled = "DISABLED",
    };
};
