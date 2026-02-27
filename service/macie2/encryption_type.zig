/// The server-side encryption algorithm that was used to encrypt an S3 object
/// or is used by default to encrypt objects that are added to an S3 bucket.
/// Possible values are:
pub const EncryptionType = enum {
    none,
    aes256,
    aws_kms,
    unknown,
    aws_kms_dsse,

    pub const json_field_names = .{
        .none = "NONE",
        .aes256 = "AES256",
        .aws_kms = "aws_kms",
        .unknown = "UNKNOWN",
        .aws_kms_dsse = "aws_kms_dsse",
    };
};
