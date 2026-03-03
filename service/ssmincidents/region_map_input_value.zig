/// The mapping between a Amazon Web Services Region and the key that's used to
/// encrypt the
/// data.
pub const RegionMapInputValue = struct {
    /// The KMS key used to encrypt the data in your replication set.
    sse_kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .sse_kms_key_id = "sseKmsKeyId",
    };
};
