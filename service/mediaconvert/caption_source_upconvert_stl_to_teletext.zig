/// Specify whether this set of input captions appears in your outputs in both
/// STL and Teletext format. If you choose Upconvert, MediaConvert includes the
/// captions data in two ways: it passes the STL data through using the Teletext
/// compatibility bytes fields of the Teletext wrapper, and it also translates
/// the STL data into Teletext.
pub const CaptionSourceUpconvertSTLToTeletext = enum {
    upconvert,
    disabled,

    pub const json_field_names = .{
        .upconvert = "UPCONVERT",
        .disabled = "DISABLED",
    };
};
