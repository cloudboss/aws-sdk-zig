const aws = @import("aws");

const AutoDataQuality = @import("auto_data_quality.zig").AutoDataQuality;
const IcebergTargetCompressionType = @import("iceberg_target_compression_type.zig").IcebergTargetCompressionType;
const TargetFormat = @import("target_format.zig").TargetFormat;
const GlueSchema = @import("glue_schema.zig").GlueSchema;
const DirectSchemaChangePolicy = @import("direct_schema_change_policy.zig").DirectSchemaChangePolicy;

/// Specifies a target that writes to an Iceberg data source in Amazon S3.
pub const S3IcebergDirectTarget = struct {
    /// Provides additional configuration options for customizing the Iceberg table
    /// behavior.
    additional_options: ?[]const aws.map.StringMapEntry = null,

    auto_data_quality: ?AutoDataQuality = null,

    /// Specifies the compression codec used for Iceberg table files in S3.
    compression: IcebergTargetCompressionType,

    /// Specifies the file format used for storing Iceberg table data (e.g.,
    /// Parquet, ORC).
    format: TargetFormat,

    /// Defines the single input source that provides data to this Iceberg target.
    inputs: []const []const u8,

    /// Specifies the unique identifier for the Iceberg target node in your data
    /// pipeline.
    name: []const u8,

    /// Sets the number of target partitions for distributing Iceberg table files
    /// across S3.
    number_target_partitions: ?[]const u8 = null,

    /// Specifies the data schema for the S3 Iceberg direct target.
    output_schemas: ?[]const GlueSchema = null,

    /// Specifies the columns used to partition the Iceberg table data in S3.
    partition_keys: ?[]const []const []const u8 = null,

    /// Defines the S3 location where the Iceberg table data will be stored.
    path: []const u8,

    /// Defines how schema changes are handled when writing data to the Iceberg
    /// table.
    schema_change_policy: ?DirectSchemaChangePolicy = null,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
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
