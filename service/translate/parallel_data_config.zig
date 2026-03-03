const ParallelDataFormat = @import("parallel_data_format.zig").ParallelDataFormat;

/// Specifies the format and S3 location of the parallel data input file.
pub const ParallelDataConfig = struct {
    /// The format of the parallel data input file.
    format: ?ParallelDataFormat = null,

    /// The URI of the Amazon S3 folder that contains the parallel data input file.
    /// The folder
    /// must be in the same Region as the API endpoint you are calling.
    s3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .format = "Format",
        .s3_uri = "S3Uri",
    };
};
