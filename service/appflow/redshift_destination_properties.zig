const ErrorHandlingConfig = @import("error_handling_config.zig").ErrorHandlingConfig;

/// The properties that are applied when Amazon Redshift is being used as a
/// destination.
pub const RedshiftDestinationProperties = struct {
    /// The object key for the bucket in which Amazon AppFlow places the destination
    /// files.
    bucket_prefix: ?[]const u8 = null,

    /// The settings that determine how Amazon AppFlow handles an error when placing
    /// data in
    /// the Amazon Redshift destination. For example, this setting would determine
    /// if the flow
    /// should fail after one insertion error, or continue and attempt to insert
    /// every record
    /// regardless of the initial failure. `ErrorHandlingConfig` is a part of the
    /// destination connector details.
    error_handling_config: ?ErrorHandlingConfig = null,

    /// The intermediate bucket that Amazon AppFlow uses when moving data into
    /// Amazon Redshift.
    intermediate_bucket_name: []const u8,

    /// The object specified in the Amazon Redshift flow destination.
    object: []const u8,

    pub const json_field_names = .{
        .bucket_prefix = "bucketPrefix",
        .error_handling_config = "errorHandlingConfig",
        .intermediate_bucket_name = "intermediateBucketName",
        .object = "object",
    };
};
