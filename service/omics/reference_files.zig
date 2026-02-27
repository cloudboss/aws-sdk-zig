const FileInformation = @import("file_information.zig").FileInformation;

/// A set of genome reference files.
pub const ReferenceFiles = struct {
    /// The files' index.
    index: ?FileInformation,

    /// The source file's location in Amazon S3.
    source: ?FileInformation,

    pub const json_field_names = .{
        .index = "index",
        .source = "source",
    };
};
