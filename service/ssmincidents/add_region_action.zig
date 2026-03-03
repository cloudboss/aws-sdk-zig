/// Defines the Amazon Web Services Region and KMS key to add to the replication
/// set.
pub const AddRegionAction = struct {
    /// The Amazon Web Services Region name to add to the replication set.
    region_name: []const u8,

    /// The KMS key ID to use to encrypt your replication set.
    sse_kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .region_name = "regionName",
        .sse_kms_key_id = "sseKmsKeyId",
    };
};
