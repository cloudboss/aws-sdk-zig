/// The S3 bucket name and file name that identifies the document.
///
/// The AWS Region for the S3 bucket that contains the document must match the
/// Region that
/// you use for Amazon Textract operations.
///
/// For Amazon Textract to process a file in an S3 bucket, the user must have
/// permission to access the S3 bucket and file.
pub const S3Object = struct {
    /// The name of the S3 bucket. Note that the # character is not valid in the
    /// file
    /// name.
    bucket: ?[]const u8,

    /// The file name of the input document. Image files may be in PDF, TIFF, JPEG,
    /// or PNG format.
    name: ?[]const u8,

    /// If the bucket has versioning enabled, you can specify the object version.
    version: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .name = "Name",
        .version = "Version",
    };
};
