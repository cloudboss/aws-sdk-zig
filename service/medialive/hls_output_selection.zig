/// Hls Output Selection
pub const HlsOutputSelection = enum {
    manifests_and_segments,
    segments_only,
    variant_manifests_and_segments,

    pub const json_field_names = .{
        .manifests_and_segments = "MANIFESTS_AND_SEGMENTS",
        .segments_only = "SEGMENTS_ONLY",
        .variant_manifests_and_segments = "VARIANT_MANIFESTS_AND_SEGMENTS",
    };
};
