const S3TablesCompressionType = @import("s3_tables_compression_type.zig").S3TablesCompressionType;
const PartitionSpec = @import("partition_spec.zig").PartitionSpec;

/// Specifies a destination streaming table on Apache Iceberg.
pub const S3TablesConfiguration = struct {
    /// The compression applied to Parquet data files. Valid values:
    ///
    /// * `NONE` - No compression.
    ///
    /// * `ZSTD` - Zstandard compression.
    ///
    /// * `SNAPPY` - Snappy compression.
    compression_type: S3TablesCompressionType,

    /// The namespace (database) of the destination table.
    namespace: []const u8,

    /// The partitioning specification for the destination table.
    partition_spec: ?PartitionSpec = null,

    /// The Amazon Resource Name (ARN) of the Amazon S3 table bucket.
    table_bucket_arn: []const u8,

    /// The name of the destination table. Amazon Kinesis Data Streams creates this
    /// table in the specified table bucket.
    table_name: []const u8,

    pub const json_field_names = .{
        .compression_type = "CompressionType",
        .namespace = "Namespace",
        .partition_spec = "PartitionSpec",
        .table_bucket_arn = "TableBucketARN",
        .table_name = "TableName",
    };
};
