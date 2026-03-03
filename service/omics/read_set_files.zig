const FileInformation = @import("file_information.zig").FileInformation;

/// Files in a read set.
pub const ReadSetFiles = struct {
    /// The files' index.
    index: ?FileInformation = null,

    /// The location of the first file in Amazon S3.
    source_1: ?FileInformation = null,

    /// The location of the second file in Amazon S3.
    source_2: ?FileInformation = null,

    pub const json_field_names = .{
        .index = "index",
        .source_1 = "source1",
        .source_2 = "source2",
    };
};
