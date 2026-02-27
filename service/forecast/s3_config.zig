/// The path to the file(s) in an Amazon Simple Storage Service (Amazon S3)
/// bucket, and an Identity and Access Management (IAM) role that
/// Amazon Forecast can assume to access the file(s). Optionally, includes an
/// Key Management Service (KMS) key. This
/// object is part of the DataSource object that is submitted in the
/// CreateDatasetImportJob request, and part of the DataDestination object.
pub const S3Config = struct {
    /// The Amazon Resource Name (ARN) of an Key Management Service (KMS) key.
    kms_key_arn: ?[]const u8,

    /// The path to an Amazon Simple Storage Service (Amazon S3) bucket or file(s)
    /// in an Amazon S3 bucket.
    path: []const u8,

    /// The ARN of the Identity and Access Management (IAM) role that Amazon
    /// Forecast can assume to access the Amazon S3
    /// bucket or files. If you provide a value for the `KMSKeyArn` key, the role
    /// must
    /// allow access to the key.
    ///
    /// Passing a role across Amazon Web Services accounts is not allowed. If you
    /// pass a role that isn't in your
    /// account, you get an `InvalidInputException` error.
    role_arn: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "KMSKeyArn",
        .path = "Path",
        .role_arn = "RoleArn",
    };
};
