/// Indicates whether the .m3u8 manifest file should be generated for this HLS
/// output group.
pub const HlsOutputSelection = enum {
    manifests_and_segments,
    segments_only,

    pub const json_field_names = .{
        .manifests_and_segments = "MANIFESTS_AND_SEGMENTS",
        .segments_only = "SEGMENTS_ONLY",
    };
};
