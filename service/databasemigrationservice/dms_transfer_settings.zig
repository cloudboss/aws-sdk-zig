/// The settings in JSON format for the DMS Transfer type source endpoint.
pub const DmsTransferSettings = struct {
    /// The name of the S3 bucket to use.
    bucket_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) used by the service access IAM role. The role
    /// must allow
    /// the `iam:PassRole` action.
    service_access_role_arn: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .service_access_role_arn = "ServiceAccessRoleArn",
    };
};
