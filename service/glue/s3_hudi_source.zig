const aws = @import("aws");

const S3DirectSourceAdditionalOptions = @import("s3_direct_source_additional_options.zig").S3DirectSourceAdditionalOptions;
const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a Hudi data source stored in Amazon S3.
pub const S3HudiSource = struct {
    /// Specifies additional connection options.
    additional_hudi_options: ?[]const aws.map.StringMapEntry,

    /// Specifies additional options for the connector.
    additional_options: ?S3DirectSourceAdditionalOptions,

    /// The name of the Hudi source.
    name: []const u8,

    /// Specifies the data schema for the Hudi source.
    output_schemas: ?[]const GlueSchema,

    /// A list of the Amazon S3 paths to read from.
    paths: []const []const u8,

    pub const json_field_names = .{
        .additional_hudi_options = "AdditionalHudiOptions",
        .additional_options = "AdditionalOptions",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .paths = "Paths",
    };
};
