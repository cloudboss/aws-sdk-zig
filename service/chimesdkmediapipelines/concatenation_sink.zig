const S3BucketSinkConfiguration = @import("s3_bucket_sink_configuration.zig").S3BucketSinkConfiguration;
const ConcatenationSinkType = @import("concatenation_sink_type.zig").ConcatenationSinkType;

/// The data sink of the configuration object.
pub const ConcatenationSink = struct {
    /// The configuration settings for an Amazon S3 bucket sink.
    s3_bucket_sink_configuration: S3BucketSinkConfiguration,

    /// The type of data sink in the configuration object.
    @"type": ConcatenationSinkType,

    pub const json_field_names = .{
        .s3_bucket_sink_configuration = "S3BucketSinkConfiguration",
        .@"type" = "Type",
    };
};
