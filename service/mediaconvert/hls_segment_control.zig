/// When set to SINGLE_FILE, emits program as a single media resource (.ts)
/// file, uses #EXT-X-BYTERANGE tags to index segment for playback.
pub const HlsSegmentControl = enum {
    single_file,
    segmented_files,

    pub const json_field_names = .{
        .single_file = "SINGLE_FILE",
        .segmented_files = "SEGMENTED_FILES",
    };
};
