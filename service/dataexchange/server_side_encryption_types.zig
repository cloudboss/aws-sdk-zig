pub const ServerSideEncryptionTypes = enum {
    aws_kms,
    aes256,

    pub const json_field_names = .{
        .aws_kms = "aws_kms",
        .aes256 = "AES256",
    };
};
