const S3DirectSourceAdditionalOptions = @import("s3_direct_source_additional_options.zig").S3DirectSourceAdditionalOptions;
const ParquetCompressionType = @import("parquet_compression_type.zig").ParquetCompressionType;
const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies an S3 Excel data source.
pub const S3ExcelSource = struct {
    /// Additional configuration options for S3 direct source processing.
    additional_options: ?S3DirectSourceAdditionalOptions,

    /// The compression format used for the Excel files.
    compression_type: ?ParquetCompressionType,

    /// Patterns to exclude specific files or paths from processing.
    exclusions: ?[]const []const u8,

    /// Specifies how files should be grouped for processing.
    group_files: ?[]const u8,

    /// Defines the size of file groups for batch processing.
    group_size: ?[]const u8,

    /// The maximum number of processing bands to use.
    max_band: ?i32,

    /// The maximum number of files to process in each band.
    max_files_in_band: ?i32,

    /// The name of the S3 Excel data source.
    name: []const u8,

    /// The number of rows to process from each Excel file.
    number_rows: ?i64,

    /// The Glue schemas to apply to the processed data.
    output_schemas: ?[]const GlueSchema,

    /// The S3 paths where the Excel files are located.
    paths: []const []const u8,

    /// Indicates whether to recursively process subdirectories.
    recurse: ?bool,

    /// The number of rows to skip at the end of each Excel file.
    skip_footer: ?i32,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .compression_type = "CompressionType",
        .exclusions = "Exclusions",
        .group_files = "GroupFiles",
        .group_size = "GroupSize",
        .max_band = "MaxBand",
        .max_files_in_band = "MaxFilesInBand",
        .name = "Name",
        .number_rows = "NumberRows",
        .output_schemas = "OutputSchemas",
        .paths = "Paths",
        .recurse = "Recurse",
        .skip_footer = "SkipFooter",
    };
};
