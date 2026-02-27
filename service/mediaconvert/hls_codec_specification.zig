/// Specification to use (RFC-6381 or the default RFC-4281) during m3u8 playlist
/// generation.
pub const HlsCodecSpecification = enum {
    rfc_6381,
    rfc_4281,

    pub const json_field_names = .{
        .rfc_6381 = "RFC_6381",
        .rfc_4281 = "RFC_4281",
    };
};
