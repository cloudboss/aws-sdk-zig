/// COMBINE_DUPLICATE_STREAMS combines identical audio encoding settings across
/// a Microsoft Smooth output group into a single audio stream.
pub const MsSmoothAudioDeduplication = enum {
    combine_duplicate_streams,
    none,

    pub const json_field_names = .{
        .combine_duplicate_streams = "COMBINE_DUPLICATE_STREAMS",
        .none = "NONE",
    };
};
