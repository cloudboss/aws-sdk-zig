const AutoDataQuality = @import("auto_data_quality.zig").AutoDataQuality;
const ParquetCompressionType = @import("parquet_compression_type.zig").ParquetCompressionType;
const DirectSchemaChangePolicy = @import("direct_schema_change_policy.zig").DirectSchemaChangePolicy;

/// Specifies a data target that writes to Amazon S3 in Apache Parquet columnar
/// storage.
pub const S3GlueParquetTarget = struct {
    /// Specifies whether to automatically enable data quality evaluation for the S3
    /// Glue Parquet target. When set to `true`,
    /// data quality checks are performed automatically during the write operation.
    auto_data_quality: ?AutoDataQuality = null,

    /// Specifies how the data is compressed. This is generally not necessary if the
    /// data has a standard file extension. Possible values are `"gzip"` and
    /// `"bzip"`).
    compression: ?ParquetCompressionType = null,

    /// The nodes that are inputs to the data target.
    inputs: []const []const u8,

    /// The name of the data target.
    name: []const u8,

    /// Specifies the number of target partitions for Parquet files when writing to
    /// Amazon S3 using Glue.
    number_target_partitions: ?[]const u8 = null,

    /// Specifies native partitioning using a sequence of keys.
    partition_keys: ?[]const []const []const u8 = null,

    /// A single Amazon S3 path to write to.
    path: []const u8,

    /// A policy that specifies update behavior for the crawler.
    schema_change_policy: ?DirectSchemaChangePolicy = null,

    pub const json_field_names = .{
        .auto_data_quality = "AutoDataQuality",
        .compression = "Compression",
        .inputs = "Inputs",
        .name = "Name",
        .number_target_partitions = "NumberTargetPartitions",
        .partition_keys = "PartitionKeys",
        .path = "Path",
        .schema_change_policy = "SchemaChangePolicy",
    };
};
