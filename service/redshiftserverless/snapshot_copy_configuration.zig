/// The object that you configure to copy snapshots from one namespace to a
/// namespace in another Amazon Web Services Region.
pub const SnapshotCopyConfiguration = struct {
    /// The ID of the KMS key to use to encrypt your snapshots in the destination
    /// Amazon Web Services Region.
    destination_kms_key_id: ?[]const u8 = null,

    /// The destination Amazon Web Services Region to copy snapshots to.
    destination_region: ?[]const u8 = null,

    /// The name of the namespace to copy snapshots from in the source Amazon Web
    /// Services Region.
    namespace_name: ?[]const u8 = null,

    /// The ARN of the snapshot copy configuration object.
    snapshot_copy_configuration_arn: ?[]const u8 = null,

    /// The ID of the snapshot copy configuration object.
    snapshot_copy_configuration_id: ?[]const u8 = null,

    /// The retention period of snapshots that are copied to the destination Amazon
    /// Web Services Region.
    snapshot_retention_period: ?i32 = null,

    pub const json_field_names = .{
        .destination_kms_key_id = "destinationKmsKeyId",
        .destination_region = "destinationRegion",
        .namespace_name = "namespaceName",
        .snapshot_copy_configuration_arn = "snapshotCopyConfigurationArn",
        .snapshot_copy_configuration_id = "snapshotCopyConfigurationId",
        .snapshot_retention_period = "snapshotRetentionPeriod",
    };
};
