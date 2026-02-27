pub const SSEAlgorithm = enum {
    aes256,
    aws_kms,

    pub const json_field_names = .{
        .aes256 = "AES256",
        .aws_kms = "AWS_KMS",
    };
};
