const ResultFormat = @import("result_format.zig").ResultFormat;

/// Contains the configuration to write the query results to S3.
pub const ProtectedQueryS3OutputConfiguration = struct {
    /// The S3 bucket to unload the protected query results.
    bucket: []const u8,

    /// The S3 prefix to unload the protected query results.
    key_prefix: ?[]const u8,

    /// Intended file format of the result.
    result_format: ResultFormat,

    /// Indicates whether files should be output as a single file (`TRUE`) or output
    /// as multiple files (`FALSE`). This parameter is only supported for analyses
    /// with the Spark analytics engine.
    single_file_output: ?bool,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key_prefix = "keyPrefix",
        .result_format = "resultFormat",
        .single_file_output = "singleFileOutput",
    };
};
