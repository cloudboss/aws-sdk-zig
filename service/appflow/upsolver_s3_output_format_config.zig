const AggregationConfig = @import("aggregation_config.zig").AggregationConfig;
const FileType = @import("file_type.zig").FileType;
const PrefixConfig = @import("prefix_config.zig").PrefixConfig;

/// The configuration that determines how Amazon AppFlow formats the flow output
/// data
/// when Upsolver is used as the destination.
pub const UpsolverS3OutputFormatConfig = struct {
    aggregation_config: ?AggregationConfig,

    /// Indicates the file type that Amazon AppFlow places in the Upsolver Amazon S3
    /// bucket.
    file_type: ?FileType,

    prefix_config: PrefixConfig,

    pub const json_field_names = .{
        .aggregation_config = "aggregationConfig",
        .file_type = "fileType",
        .prefix_config = "prefixConfig",
    };
};
