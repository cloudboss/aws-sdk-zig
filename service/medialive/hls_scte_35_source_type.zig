/// Hls Scte35 Source Type
pub const HlsScte35SourceType = enum {
    manifest,
    segments,

    pub const json_field_names = .{
        .manifest = "MANIFEST",
        .segments = "SEGMENTS",
    };
};
