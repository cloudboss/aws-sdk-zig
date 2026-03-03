const S3Object = @import("s3_object.zig").S3Object;

/// The Amazon S3 bucket that contains the document to be processed. It's used
/// by asynchronous
/// operations.
///
/// The input document can be an image file in JPEG or PNG format. It can also
/// be a file in
/// PDF format.
pub const DocumentLocation = struct {
    /// The Amazon S3 bucket that contains the input document.
    s3_object: ?S3Object = null,

    pub const json_field_names = .{
        .s3_object = "S3Object",
    };
};
