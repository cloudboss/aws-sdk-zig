/// The settings that determine how Amazon AppFlow handles an error when placing
/// data in
/// the destination. For example, this setting would determine if the flow
/// should fail after one
/// insertion error, or continue and attempt to insert every record regardless
/// of the initial
/// failure. `ErrorHandlingConfig` is a part of the destination connector
/// details.
pub const ErrorHandlingConfig = struct {
    /// Specifies the name of the Amazon S3 bucket.
    bucket_name: ?[]const u8 = null,

    /// Specifies the Amazon S3 bucket prefix.
    bucket_prefix: ?[]const u8 = null,

    /// Specifies if the flow should fail after the first instance of a failure when
    /// attempting
    /// to place data in the destination.
    fail_on_first_destination_error: bool = false,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .bucket_prefix = "bucketPrefix",
        .fail_on_first_destination_error = "failOnFirstDestinationError",
    };
};
