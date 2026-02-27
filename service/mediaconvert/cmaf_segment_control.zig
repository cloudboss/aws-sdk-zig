/// When set to SINGLE_FILE, a single output file is generated, which is
/// internally segmented using the Fragment Length and Segment Length. When set
/// to SEGMENTED_FILES, separate segment files will be created.
pub const CmafSegmentControl = enum {
    single_file,
    segmented_files,

    pub const json_field_names = .{
        .single_file = "SINGLE_FILE",
        .segmented_files = "SEGMENTED_FILES",
    };
};
