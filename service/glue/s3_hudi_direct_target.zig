const aws = @import("aws");

const AutoDataQuality = @import("auto_data_quality.zig").AutoDataQuality;
const HudiTargetCompressionType = @import("hudi_target_compression_type.zig").HudiTargetCompressionType;
const TargetFormat = @import("target_format.zig").TargetFormat;
const DirectSchemaChangePolicy = @import("direct_schema_change_policy.zig").DirectSchemaChangePolicy;

/// Specifies a target that writes to a Hudi data source in Amazon S3.
pub const S3HudiDirectTarget = struct {
    /// Specifies additional connection options for the connector.
    additional_options: []const aws.map.StringMapEntry,

    /// Specifies whether to automatically enable data quality evaluation for the S3
    /// Hudi direct target. When set to `true`,
    /// data quality checks are performed automatically during the write operation.
    auto_data_quality: ?AutoDataQuality,

    /// Specifies how the data is compressed. This is generally not necessary if the
    /// data has a standard file extension. Possible values are `"gzip"` and
    /// `"bzip"`).
    compression: HudiTargetCompressionType,

    /// Specifies the data output format for the target.
    format: TargetFormat,

    /// The nodes that are inputs to the data target.
    inputs: []const []const u8,

    /// The name of the data target.
    name: []const u8,

    /// Specifies the number of target partitions for distributing Hudi dataset
    /// files across Amazon S3.
    number_target_partitions: ?[]const u8,

    /// Specifies native partitioning using a sequence of keys.
    partition_keys: ?[]const []const []const u8,

    /// The Amazon S3 path of your Hudi data source to write to.
    path: []const u8,

    /// A policy that specifies update behavior for the crawler.
    schema_change_policy: ?DirectSchemaChangePolicy,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .auto_data_quality = "AutoDataQuality",
        .compression = "Compression",
        .format = "Format",
        .inputs = "Inputs",
        .name = "Name",
        .number_target_partitions = "NumberTargetPartitions",
        .partition_keys = "PartitionKeys",
        .path = "Path",
        .schema_change_policy = "SchemaChangePolicy",
    };
};
