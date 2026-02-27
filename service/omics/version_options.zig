const TsvVersionOptions = @import("tsv_version_options.zig").TsvVersionOptions;

/// The options for an annotation store version.
pub const VersionOptions = union(enum) {
    /// File settings for a version of a TSV store.
    tsv_version_options: ?TsvVersionOptions,

    pub const json_field_names = .{
        .tsv_version_options = "tsvVersionOptions",
    };
};
