/// Hls Ts File Mode
pub const HlsTsFileMode = enum {
    segmented_files,
    single_file,

    pub const json_field_names = .{
        .segmented_files = "SEGMENTED_FILES",
        .single_file = "SINGLE_FILE",
    };
};
