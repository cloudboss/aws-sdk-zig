/// Aac Spec
pub const AacSpec = enum {
    mpeg2,
    mpeg4,

    pub const json_field_names = .{
        .mpeg2 = "MPEG2",
        .mpeg4 = "MPEG4",
    };
};
