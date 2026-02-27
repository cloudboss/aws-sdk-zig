const S3DirectSourceAdditionalOptions = @import("s3_direct_source_additional_options.zig").S3DirectSourceAdditionalOptions;
const CompressionType = @import("compression_type.zig").CompressionType;
const GlueSchema = @import("glue_schema.zig").GlueSchema;
const QuoteChar = @import("quote_char.zig").QuoteChar;
const Separator = @import("separator.zig").Separator;

/// Specifies a command-separated value (CSV) data store stored in Amazon S3.
pub const S3CsvSource = struct {
    /// Specifies additional connection options.
    additional_options: ?S3DirectSourceAdditionalOptions,

    /// Specifies how the data is compressed. This is generally not necessary if the
    /// data has a standard file extension. Possible values are `"gzip"` and
    /// `"bzip"`).
    compression_type: ?CompressionType,

    /// Specifies a character to use for escaping. This option is used only when
    /// reading CSV files. The default value is `none`. If enabled, the character
    /// which immediately follows is used as-is, except for a small set of
    /// well-known escapes (`\n`, `\r`, `\t`, and `\0`).
    escaper: ?[]const u8,

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

    /// A Boolean value that specifies whether a single record can span multiple
    /// lines. This can occur when a field contains a quoted new-line character. You
    /// must set this option to True if any record spans multiple lines. The default
    /// value is `False`, which allows for more aggressive file-splitting during
    /// parsing.
    multiline: ?bool,

    /// The name of the data store.
    name: []const u8,

    /// A Boolean value that specifies whether to use the advanced SIMD CSV reader
    /// along with Apache Arrow based columnar memory formats. Only available in
    /// Glue version 3.0.
    optimize_performance: bool = false,

    /// Specifies the data schema for the S3 CSV source.
    output_schemas: ?[]const GlueSchema,

    /// A list of the Amazon S3 paths to read from.
    paths: []const []const u8,

    /// Specifies the character to use for quoting. The default is a double quote:
    /// `'"'`. Set this to `-1` to turn off quoting entirely.
    quote_char: QuoteChar,

    /// If set to true, recursively reads files in all subdirectories under the
    /// specified paths.
    recurse: ?bool,

    /// Specifies the delimiter character. The default is a comma: ",", but any
    /// other character can be specified.
    separator: Separator,

    /// A Boolean value that specifies whether to skip the first data line. The
    /// default value is `False`.
    skip_first: ?bool,

    /// A Boolean value that specifies whether to treat the first line as a header.
    /// The default value is `False`.
    with_header: ?bool,

    /// A Boolean value that specifies whether to write the header to output. The
    /// default value is `True`.
    write_header: ?bool,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .compression_type = "CompressionType",
        .escaper = "Escaper",
        .exclusions = "Exclusions",
        .group_files = "GroupFiles",
        .group_size = "GroupSize",
        .max_band = "MaxBand",
        .max_files_in_band = "MaxFilesInBand",
        .multiline = "Multiline",
        .name = "Name",
        .optimize_performance = "OptimizePerformance",
        .output_schemas = "OutputSchemas",
        .paths = "Paths",
        .quote_char = "QuoteChar",
        .recurse = "Recurse",
        .separator = "Separator",
        .skip_first = "SkipFirst",
        .with_header = "WithHeader",
        .write_header = "WriteHeader",
    };
};
