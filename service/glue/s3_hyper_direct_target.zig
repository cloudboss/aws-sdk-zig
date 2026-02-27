const AutoDataQuality = @import("auto_data_quality.zig").AutoDataQuality;
const HyperTargetCompressionType = @import("hyper_target_compression_type.zig").HyperTargetCompressionType;
const TargetFormat = @import("target_format.zig").TargetFormat;
const GlueSchema = @import("glue_schema.zig").GlueSchema;
const DirectSchemaChangePolicy = @import("direct_schema_change_policy.zig").DirectSchemaChangePolicy;

/// Specifies a HyperDirect data target that writes to Amazon S3.
pub const S3HyperDirectTarget = struct {
    /// Specifies whether to automatically enable data quality evaluation for the S3
    /// Hyper direct target. When set to `true`, data quality checks are performed
    /// automatically during the write operation.
    auto_data_quality: ?AutoDataQuality,

    /// The compression type to apply to the output data.
    compression: ?HyperTargetCompressionType,

    /// Specifies the data output format for the HyperDirect target.
    format: ?TargetFormat,

    /// Specifies the input source for the HyperDirect target.
    inputs: []const []const u8,

    /// The unique identifier for the HyperDirect target node.
    name: []const u8,

    /// Specifies the data schema for the S3 Hyper direct target.
    output_schemas: ?[]const GlueSchema,

    /// Defines the partitioning strategy for the output data.
    partition_keys: ?[]const []const []const u8,

    /// The S3 location where the output data will be written.
    path: []const u8,

    /// Defines how schema changes are handled during write operations.
    schema_change_policy: ?DirectSchemaChangePolicy,

    pub const json_field_names = .{
        .auto_data_quality = "AutoDataQuality",
        .compression = "Compression",
        .format = "Format",
        .inputs = "Inputs",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .partition_keys = "PartitionKeys",
        .path = "Path",
        .schema_change_policy = "SchemaChangePolicy",
    };
};
