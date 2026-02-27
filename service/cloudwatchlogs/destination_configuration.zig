const S3Configuration = @import("s3_configuration.zig").S3Configuration;

/// Configuration for where to deliver scheduled query results. Specifies the
/// destination type
/// and associated settings for result delivery.
pub const DestinationConfiguration = struct {
    /// Configuration for delivering query results to Amazon S3.
    s_3_configuration: S3Configuration,

    pub const json_field_names = .{
        .s_3_configuration = "s3Configuration",
    };
};
