const S3Object = @import("s3_object.zig").S3Object;

/// Provides the input image either as bytes or an S3 object.
///
/// You pass image bytes to an Amazon Rekognition API operation by using the
/// `Bytes`
/// property. For example, you would use the `Bytes` property to pass an image
/// loaded
/// from a local file system. Image bytes passed by using the `Bytes` property
/// must be
/// base64-encoded. Your code may not need to encode image bytes if you are
/// using an AWS SDK to
/// call Amazon Rekognition API operations.
///
/// For more information, see Analyzing an Image Loaded from a Local File System
/// in the Amazon Rekognition Developer Guide.
///
/// You pass images stored in an S3 bucket to an Amazon Rekognition API
/// operation by using the
/// `S3Object` property. Images stored in an S3 bucket do not need to be
/// base64-encoded.
///
/// The region for the S3 bucket containing the S3 object must match the region
/// you use for
/// Amazon Rekognition operations.
///
/// If you use the AWS CLI to call Amazon Rekognition operations, passing image
/// bytes using the
/// Bytes property is not supported. You must first upload the image to an
/// Amazon S3 bucket and
/// then call the operation using the S3Object property.
///
/// For Amazon Rekognition to process an S3 object, the user must have
/// permission to
/// access the S3 object. For more information, see How Amazon Rekognition works
/// with IAM in the
/// Amazon Rekognition Developer Guide.
pub const Image = struct {
    /// Blob of image bytes up to 5 MBs. Note that the maximum image size you can
    /// pass to `DetectCustomLabels` is 4MB.
    bytes: ?[]const u8,

    /// Identifies an S3 object as the image source.
    s3_object: ?S3Object,

    pub const json_field_names = .{
        .bytes = "Bytes",
        .s3_object = "S3Object",
    };
};
