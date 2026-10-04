const SourceFormat = @import("source_format.zig").SourceFormat;

/// The Amazon S3 location and source format configuration for input data in a
/// transformation job.
pub const TransformationInputDataConfig = struct {
    /// The Amazon S3 URI of the input data to transform.
    s3_uri: []const u8,

    /// The format of the source data files (C-CDA or CSV).
    source_format: ?SourceFormat = null,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
        .source_format = "SourceFormat",
    };
};
