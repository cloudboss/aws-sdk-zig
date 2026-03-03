const ProcessingS3CompressionType = @import("processing_s3_compression_type.zig").ProcessingS3CompressionType;
const ProcessingS3DataDistributionType = @import("processing_s3_data_distribution_type.zig").ProcessingS3DataDistributionType;
const ProcessingS3DataType = @import("processing_s3_data_type.zig").ProcessingS3DataType;
const ProcessingS3InputMode = @import("processing_s3_input_mode.zig").ProcessingS3InputMode;

/// Configuration for downloading input data from Amazon S3 into the processing
/// container.
pub const ProcessingS3Input = struct {
    /// The local path in your container where you want Amazon SageMaker to write
    /// input data to. `LocalPath` is an absolute path to the input data and must
    /// begin with `/opt/ml/processing/`. `LocalPath` is a required parameter when
    /// `AppManaged` is `False` (default).
    local_path: ?[]const u8 = null,

    /// Whether to GZIP-decompress the data in Amazon S3 as it is streamed into the
    /// processing container. `Gzip` can only be used when `Pipe` mode is specified
    /// as the `S3InputMode`. In `Pipe` mode, Amazon SageMaker streams input data
    /// from the source directly to your container without using the EBS volume.
    s3_compression_type: ?ProcessingS3CompressionType = null,

    /// Whether to distribute the data from Amazon S3 to all processing instances
    /// with `FullyReplicated`, or whether the data from Amazon S3 is sharded by
    /// Amazon S3 key, downloading one shard of data to each processing instance.
    s3_data_distribution_type: ?ProcessingS3DataDistributionType = null,

    /// Whether you use an `S3Prefix` or a `ManifestFile` for the data type. If you
    /// choose `S3Prefix`, `S3Uri` identifies a key name prefix. Amazon SageMaker
    /// uses all objects with the specified key name prefix for the processing job.
    /// If you choose `ManifestFile`, `S3Uri` identifies an object that is a
    /// manifest file containing a list of object keys that you want Amazon
    /// SageMaker to use for the processing job.
    s3_data_type: ProcessingS3DataType,

    /// Whether to use `File` or `Pipe` input mode. In File mode, Amazon SageMaker
    /// copies the data from the input source onto the local ML storage volume
    /// before starting your processing container. This is the most commonly used
    /// input mode. In `Pipe` mode, Amazon SageMaker streams input data from the
    /// source directly to your processing container into named pipes without using
    /// the ML storage volume.
    s3_input_mode: ?ProcessingS3InputMode = null,

    /// The URI of the Amazon S3 prefix Amazon SageMaker downloads data required to
    /// run a processing job.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .local_path = "LocalPath",
        .s3_compression_type = "S3CompressionType",
        .s3_data_distribution_type = "S3DataDistributionType",
        .s3_data_type = "S3DataType",
        .s3_input_mode = "S3InputMode",
        .s3_uri = "S3Uri",
    };
};
