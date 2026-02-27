const FileFormat = @import("file_format.zig").FileFormat;

/// Contains the configuration information of a job, such as the file format
/// used to save data in Amazon S3.
pub const JobConfiguration = struct {
    /// The file format of the data in S3.
    file_format: FileFormat,

    pub const json_field_names = .{
        .file_format = "fileFormat",
    };
};
