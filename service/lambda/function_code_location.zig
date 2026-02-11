/// Details about a function's deployment package.
pub const FunctionCodeLocation = struct {
    /// URI of a container image in the Amazon ECR registry.
    image_uri: ?[]const u8,

    /// A presigned URL that you can use to download the deployment package.
    location: ?[]const u8,

    /// The service that's hosting the file.
    repository_type: ?[]const u8,

    /// The resolved URI for the image.
    resolved_image_uri: ?[]const u8,

    /// The ARN of the Key Management Service (KMS) customer managed key that's used
    /// to encrypt your function's .zip deployment package. If you don't provide a
    /// customer managed key, Lambda uses an [Amazon Web Services owned
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-owned-cmk).
    source_kms_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .image_uri = "ImageUri",
        .location = "Location",
        .repository_type = "RepositoryType",
        .resolved_image_uri = "ResolvedImageUri",
        .source_kms_key_arn = "SourceKMSKeyArn",
    };
};
