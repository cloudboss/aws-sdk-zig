const FileFormat = @import("file_format.zig").FileFormat;
const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;

/// The file in Amazon S3 where your data is saved.
pub const File = struct {
    /// The alias associated with the file's time series.
    alias: ?[]const u8 = null,

    /// The name of the Amazon S3 bucket from which data is imported.
    bucket: []const u8,

    /// The file format of the data in S3.
    file_format: ?FileFormat = null,

    /// The key of the Amazon S3 object that contains your data. Each object has a
    /// key that is a unique
    /// identifier. Each object has exactly one key.
    key: []const u8,

    /// The nanosecond-precision start time for the file data.
    start_time: ?TimeInNanos = null,

    /// The version ID to identify a specific version of the Amazon S3 object that
    /// contains your
    /// data.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias = "alias",
        .bucket = "bucket",
        .file_format = "fileFormat",
        .key = "key",
        .start_time = "startTime",
        .version_id = "versionId",
    };
};
