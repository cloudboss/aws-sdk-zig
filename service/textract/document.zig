const S3Object = @import("s3_object.zig").S3Object;

/// The input document, either as bytes or as an S3 object.
///
/// You pass image bytes to an Amazon Textract API operation by using the
/// `Bytes`
/// property. For example, you would use the `Bytes` property to pass a document
/// loaded from a local file system. Image bytes passed by using the `Bytes`
/// property must be base64 encoded. Your code might not need to encode document
/// file bytes if
/// you're using an AWS SDK to call Amazon Textract API operations.
///
/// You pass images stored in an S3 bucket to an Amazon Textract API operation
/// by using the
/// `S3Object` property. Documents stored in an S3 bucket don't need to be
/// base64
/// encoded.
///
/// The AWS Region for the S3 bucket that contains the S3 object must match the
/// AWS
/// Region that you use for Amazon Textract operations.
///
/// If you use the AWS CLI to call Amazon Textract operations, passing image
/// bytes using
/// the Bytes property isn't supported. You must first upload the document to an
/// Amazon S3
/// bucket, and then call the operation using the S3Object property.
///
/// For Amazon Textract to process an S3 object, the user must have permission
/// to access the S3 object.
pub const Document = struct {
    /// A blob of base64-encoded document bytes. The maximum size of a document
    /// that's provided
    /// in a blob of bytes is 5 MB. The document bytes must be in PNG or JPEG
    /// format.
    ///
    /// If you're using an AWS SDK to call Amazon Textract, you might not need to
    /// base64-encode
    /// image bytes passed using the `Bytes` field.
    bytes: ?[]const u8,

    /// Identifies an S3 object as the document source. The maximum size of a
    /// document that's
    /// stored in an S3 bucket is 5 MB.
    s3_object: ?S3Object,

    pub const json_field_names = .{
        .bytes = "Bytes",
        .s3_object = "S3Object",
    };
};
