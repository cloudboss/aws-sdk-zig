/// Hls Codec Specification
pub const HlsCodecSpecification = enum {
    rfc_4281,
    rfc_6381,

    pub const json_field_names = .{
        .rfc_4281 = "RFC_4281",
        .rfc_6381 = "RFC_6381",
    };
};
