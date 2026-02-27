pub const Type = enum {
    none,
    aes256,
    aws_kms,
    aws_kms_dsse,

    pub const json_field_names = .{
        .none = "NONE",
        .aes256 = "AES256",
        .aws_kms = "aws_kms",
        .aws_kms_dsse = "aws_kms_dsse",
    };
};
