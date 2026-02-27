/// Determines how Amazon AppFlow handles the success response that it gets from
/// the
/// connector after placing data.
///
/// For example, this setting would determine where to write the response from
/// the destination
/// connector upon a successful insert operation.
pub const SuccessResponseHandlingConfig = struct {
    /// The name of the Amazon S3 bucket.
    bucket_name: ?[]const u8,

    /// The Amazon S3 bucket prefix.
    bucket_prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .bucket_prefix = "bucketPrefix",
    };
};
