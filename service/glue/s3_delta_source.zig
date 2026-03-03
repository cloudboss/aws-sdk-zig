const aws = @import("aws");

const S3DirectSourceAdditionalOptions = @import("s3_direct_source_additional_options.zig").S3DirectSourceAdditionalOptions;
const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a Delta Lake data source stored in Amazon S3.
pub const S3DeltaSource = struct {
    /// Specifies additional connection options.
    additional_delta_options: ?[]const aws.map.StringMapEntry = null,

    /// Specifies additional options for the connector.
    additional_options: ?S3DirectSourceAdditionalOptions = null,

    /// The name of the Delta Lake source.
    name: []const u8,

    /// Specifies the data schema for the Delta Lake source.
    output_schemas: ?[]const GlueSchema = null,

    /// A list of the Amazon S3 paths to read from.
    paths: []const []const u8,

    pub const json_field_names = .{
        .additional_delta_options = "AdditionalDeltaOptions",
        .additional_options = "AdditionalOptions",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .paths = "Paths",
    };
};
