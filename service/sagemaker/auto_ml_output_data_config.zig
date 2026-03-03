/// The output data configuration.
pub const AutoMLOutputDataConfig = struct {
    /// The Key Management Service encryption key ID.
    kms_key_id: ?[]const u8 = null,

    /// The Amazon S3 output path. Must be 512 characters or less.
    s3_output_path: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .s3_output_path = "S3OutputPath",
    };
};
