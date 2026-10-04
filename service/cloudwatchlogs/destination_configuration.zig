const LookupTableConfiguration = @import("lookup_table_configuration.zig").LookupTableConfiguration;
const S3Configuration = @import("s3_configuration.zig").S3Configuration;

/// Configuration for where to deliver scheduled query results. Specifies the
/// destination type
/// and associated settings for result delivery.
pub const DestinationConfiguration = struct {
    /// Configuration for delivering query results to a lookup table. The query
    /// results
    /// automatically populate or refresh the specified lookup table on each
    /// scheduled
    /// execution.
    lookup_table_configuration: ?LookupTableConfiguration = null,

    /// Configuration for delivering query results to Amazon S3.
    s_3_configuration: ?S3Configuration = null,

    pub const json_field_names = .{
        .lookup_table_configuration = "lookupTableConfiguration",
        .s_3_configuration = "s3Configuration",
    };
};
