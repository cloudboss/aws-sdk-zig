const AutoDataQuality = @import("auto_data_quality.zig").AutoDataQuality;
const TargetFormat = @import("target_format.zig").TargetFormat;
const GlueSchema = @import("glue_schema.zig").GlueSchema;
const DirectSchemaChangePolicy = @import("direct_schema_change_policy.zig").DirectSchemaChangePolicy;

/// Specifies a data target that writes to Amazon S3.
pub const S3DirectTarget = struct {
    /// Specifies whether to automatically enable data quality evaluation for the S3
    /// direct target. When set to `true`,
    /// data quality checks are performed automatically during the write operation.
    auto_data_quality: ?AutoDataQuality,

    /// Specifies how the data is compressed. This is generally not necessary if the
    /// data has a standard file extension. Possible values are `"gzip"` and
    /// `"bzip"`).
    compression: ?[]const u8,

    /// Specifies the data output format for the target.
    format: TargetFormat,

    /// The nodes that are inputs to the data target.
    inputs: []const []const u8,

    /// The name of the data target.
    name: []const u8,

    /// Specifies the number of target partitions when writing data directly to
    /// Amazon S3.
    number_target_partitions: ?[]const u8,

    /// Specifies the data schema for the S3 direct target.
    output_schemas: ?[]const GlueSchema,

    /// Specifies native partitioning using a sequence of keys.
    partition_keys: ?[]const []const []const u8,

    /// A single Amazon S3 path to write to.
    path: []const u8,

    /// A policy that specifies update behavior for the crawler.
    schema_change_policy: ?DirectSchemaChangePolicy,

    pub const json_field_names = .{
        .auto_data_quality = "AutoDataQuality",
        .compression = "Compression",
        .format = "Format",
        .inputs = "Inputs",
        .name = "Name",
        .number_target_partitions = "NumberTargetPartitions",
        .output_schemas = "OutputSchemas",
        .partition_keys = "PartitionKeys",
        .path = "Path",
        .schema_change_policy = "SchemaChangePolicy",
    };
};
