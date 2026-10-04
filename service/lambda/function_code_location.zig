const FunctionCodeLocationError = @import("function_code_location_error.zig").FunctionCodeLocationError;
const ResolvedS3Object = @import("resolved_s3_object.zig").ResolvedS3Object;

/// Details about a function's deployment package.
pub const FunctionCodeLocation = struct {
    /// An object that contains details about an error related to function
    /// deployment package retrieval.
    @"error": ?FunctionCodeLocationError = null,

    /// URI of a container image in the Amazon ECR registry.
    image_uri: ?[]const u8 = null,

    /// A presigned URL that you can use to download the deployment package.
    location: ?[]const u8 = null,

    /// The service that's hosting the file.
    repository_type: ?[]const u8 = null,

    /// The resolved URI for the image.
    resolved_image_uri: ?[]const u8 = null,

    /// The resolved Amazon S3 object that contains the deployment package.
    resolved_s3_object: ?ResolvedS3Object = null,

    /// The ARN of the Key Management Service (KMS) customer managed key that's used
    /// to encrypt your function's .zip deployment package. If you don't provide a
    /// customer managed key, Lambda uses an [Amazon Web Services owned
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-owned-cmk).
    source_kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"error" = "Error",
        .image_uri = "ImageUri",
        .location = "Location",
        .repository_type = "RepositoryType",
        .resolved_image_uri = "ResolvedImageUri",
        .resolved_s3_object = "ResolvedS3Object",
        .source_kms_key_arn = "SourceKMSKeyArn",
    };
};
