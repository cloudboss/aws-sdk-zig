/// Use MPEG-2 AAC instead of MPEG-4 AAC audio for raw or MPEG-2 Transport
/// Stream containers.
pub const AacSpecification = enum {
    mpeg2,
    mpeg4,

    pub const json_field_names = .{
        .mpeg2 = "MPEG2",
        .mpeg4 = "MPEG4",
    };
};
