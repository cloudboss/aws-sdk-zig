/// Specifies the path to the S3 location where you want to store hybrid job
/// artifacts and the encryption key used to store them.
pub const JobOutputDataConfig = struct {
    /// The AWS Key Management Service (AWS KMS) key that Amazon Braket uses to
    /// encrypt the hybrid job training artifacts at rest using Amazon S3
    /// server-side encryption.
    kms_key_id: ?[]const u8 = null,

    /// Identifies the S3 path where you want Amazon Braket to store the hybrid job
    /// training artifacts. For example, `s3://bucket-name/key-name-prefix`.
    s_3_path: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
        .s_3_path = "s3Path",
    };
};
