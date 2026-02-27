/// Unless you need Omneon compatibility: Keep the default value, None. To make
/// this output compatible with Omneon: Choose Omneon. When you do, MediaConvert
/// increases the length of the 'elst' edit list atom. Note that this might
/// cause file rejections when a recipient of the output file doesn't expect
/// this extra padding.
pub const MovPaddingControl = enum {
    omneon,
    none,

    pub const json_field_names = .{
        .omneon = "OMNEON",
        .none = "NONE",
    };
};
