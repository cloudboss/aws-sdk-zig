const AggregationConfig = @import("aggregation_config.zig").AggregationConfig;
const FileType = @import("file_type.zig").FileType;
const PrefixConfig = @import("prefix_config.zig").PrefixConfig;

/// The configuration that determines how Amazon AppFlow should format the flow
/// output
/// data when Amazon S3 is used as the destination.
pub const S3OutputFormatConfig = struct {
    aggregation_config: ?AggregationConfig = null,

    /// Indicates the file type that Amazon AppFlow places in the Amazon S3 bucket.
    file_type: ?FileType = null,

    /// Determines the prefix that Amazon AppFlow applies to the folder name in the
    /// Amazon S3 bucket. You can name folders according to the flow frequency and
    /// date.
    prefix_config: ?PrefixConfig = null,

    /// If your file output format is Parquet, use this parameter to set whether
    /// Amazon AppFlow preserves the data types in your source data when it writes
    /// the output to Amazon S3.
    ///
    /// * `true`: Amazon AppFlow preserves the data types when it writes to
    /// Amazon S3. For example, an integer or `1` in your source data is
    /// still an integer in your output.
    ///
    /// * `false`: Amazon AppFlow converts all of the source data into strings
    /// when it writes to Amazon S3. For example, an integer of `1` in your
    /// source data becomes the string `"1"` in the output.
    preserve_source_data_typing: ?bool = null,

    pub const json_field_names = .{
        .aggregation_config = "aggregationConfig",
        .file_type = "fileType",
        .prefix_config = "prefixConfig",
        .preserve_source_data_typing = "preserveSourceDataTyping",
    };
};
