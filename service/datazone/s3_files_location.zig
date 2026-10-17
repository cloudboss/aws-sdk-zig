const S3File = @import("s3_file.zig").S3File;

/// The Amazon Simple Storage Service objects to import as the cells of a
/// notebook, specified as a bucket and an ordered list of object keys.
pub const S3FilesLocation = struct {
    /// The name of the Amazon Simple Storage Service bucket that contains the files
    /// to import.
    bucket: []const u8,

    /// The files to import. Cells are created in the order in which you list the
    /// files. You can specify between 1 and 100 files.
    file_list: []const S3File,

    pub const json_field_names = .{
        .bucket = "bucket",
        .file_list = "fileList",
    };
};
