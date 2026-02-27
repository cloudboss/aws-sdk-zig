pub const OriginType = enum {
    aws_kms,
    external,
    aws_cloudhsm,
    external_key_store,

    pub const json_field_names = .{
        .aws_kms = "AWS_KMS",
        .external = "EXTERNAL",
        .aws_cloudhsm = "AWS_CLOUDHSM",
        .external_key_store = "EXTERNAL_KEY_STORE",
    };
};
