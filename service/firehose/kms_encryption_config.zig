/// Describes an encryption key for a destination in Amazon S3.
pub const KMSEncryptionConfig = struct {
    /// The Amazon Resource Name (ARN) of the encryption key. Must belong to the
    /// same Amazon Web Services Region as the destination Amazon S3 bucket. For
    /// more information, see [Amazon
    /// Resource Names (ARNs) and Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    awskms_key_arn: []const u8,

    pub const json_field_names = .{
        .awskms_key_arn = "AWSKMSKeyARN",
    };
};
