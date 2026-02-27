/// Indicates whether segments should be placed in subdirectories.
pub const HlsDirectoryStructure = enum {
    single_directory,
    subdirectory_per_stream,

    pub const json_field_names = .{
        .single_directory = "SINGLE_DIRECTORY",
        .subdirectory_per_stream = "SUBDIRECTORY_PER_STREAM",
    };
};
