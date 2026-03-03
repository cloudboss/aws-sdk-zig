const DatasetSource = @import("dataset_source.zig").DatasetSource;
const FileSystemDataSource = @import("file_system_data_source.zig").FileSystemDataSource;
const S3DataSource = @import("s3_data_source.zig").S3DataSource;

/// Describes the location of the channel data.
pub const DataSource = struct {
    /// The dataset resource that's associated with a channel.
    dataset_source: ?DatasetSource = null,

    /// The file system that is associated with a channel.
    file_system_data_source: ?FileSystemDataSource = null,

    /// The S3 location of the data source that is associated with a channel.
    s3_data_source: ?S3DataSource = null,

    pub const json_field_names = .{
        .dataset_source = "DatasetSource",
        .file_system_data_source = "FileSystemDataSource",
        .s3_data_source = "S3DataSource",
    };
};
