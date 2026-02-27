pub const CustomKeyStoreType = enum {
    aws_cloudhsm,
    external_key_store,

    pub const json_field_names = .{
        .aws_cloudhsm = "AWS_CLOUDHSM",
        .external_key_store = "EXTERNAL_KEY_STORE",
    };
};
