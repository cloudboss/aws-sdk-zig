/// When set to "standard", an I-Frame only playlist will be written out for
/// each video output in the output group. This I-Frame only playlist will
/// contain byte range offsets pointing to the I-frame(s) in each segment.
pub const IFrameOnlyPlaylistType = enum {
    disabled,
    standard,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .standard = "STANDARD",
    };
};
