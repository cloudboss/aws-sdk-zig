const S3DirectSourceAdditionalOptions = @import("s3_direct_source_additional_options.zig").S3DirectSourceAdditionalOptions;
const ParquetCompressionType = @import("parquet_compression_type.zig").ParquetCompressionType;
const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies an Apache Parquet data store stored in Amazon S3.
pub const S3ParquetSource = struct {
    /// Specifies additional connection options.
    additional_options: ?S3DirectSourceAdditionalOptions,

    /// Specifies how the data is compressed. This is generally not necessary if the
    /// data has a standard file extension. Possible values are `"gzip"` and
    /// `"bzip"`).
    compression_type: ?ParquetCompressionType,

    /// A string containing a JSON list of Unix-style glob patterns to exclude. For
    /// example, "[\"**.pdf\"]" excludes all PDF files.
    exclusions: ?[]const []const u8,

    /// Grouping files is turned on by default when the input contains more than
    /// 50,000 files. To turn on grouping with fewer than 50,000 files, set this
    /// parameter to "inPartition". To disable grouping when there are more than
    /// 50,000 files, set this parameter to `"none"`.
    group_files: ?[]const u8,

    /// The target group size in bytes. The default is computed based on the input
    /// data size and the size of your cluster. When there are fewer than 50,000
    /// input files, `"groupFiles"` must be set to `"inPartition"` for this to take
    /// effect.
    group_size: ?[]const u8,

    /// This option controls the duration in milliseconds after which the s3 listing
    /// is likely to be consistent. Files with modification timestamps falling
    /// within the last maxBand milliseconds are tracked specially when using
    /// JobBookmarks to account for Amazon S3 eventual consistency. Most users don't
    /// need to set this option. The default is 900000 milliseconds, or 15 minutes.
    max_band: ?i32,

    /// This option specifies the maximum number of files to save from the last
    /// maxBand seconds. If this number is exceeded, extra files are skipped and
    /// only processed in the next job run.
    max_files_in_band: ?i32,

    /// The name of the data store.
    name: []const u8,

    /// Specifies the data schema for the S3 Parquet source.
    output_schemas: ?[]const GlueSchema,

    /// A list of the Amazon S3 paths to read from.
    paths: []const []const u8,

    /// If set to true, recursively reads files in all subdirectories under the
    /// specified paths.
    recurse: ?bool,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .compression_type = "CompressionType",
        .exclusions = "Exclusions",
        .group_files = "GroupFiles",
        .group_size = "GroupSize",
        .max_band = "MaxBand",
        .max_files_in_band = "MaxFilesInBand",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .paths = "Paths",
        .recurse = "Recurse",
    };
};
