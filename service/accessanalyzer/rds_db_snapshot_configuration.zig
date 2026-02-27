const aws = @import("aws");

const RdsDbSnapshotAttributeValue = @import("rds_db_snapshot_attribute_value.zig").RdsDbSnapshotAttributeValue;

/// The proposed access control configuration for an Amazon RDS DB snapshot. You
/// can propose a configuration for a new Amazon RDS DB snapshot or an Amazon
/// RDS DB snapshot that you own by specifying the `RdsDbSnapshotAttributeValue`
/// and optional KMS encryption key. For more information, see
/// [ModifyDBSnapshotAttribute](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_ModifyDBSnapshotAttribute.html).
pub const RdsDbSnapshotConfiguration = struct {
    /// The names and values of manual DB snapshot attributes. Manual DB snapshot
    /// attributes are used to authorize other Amazon Web Services accounts to
    /// restore a manual DB snapshot. The only valid value for `attributeName` for
    /// the attribute map is restore.
    attributes: ?[]const aws.map.MapEntry(RdsDbSnapshotAttributeValue),

    /// The KMS key identifier for an encrypted Amazon RDS DB snapshot. The KMS key
    /// identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key.
    ///
    /// * If the configuration is for an existing Amazon RDS DB snapshot and you do
    ///   not specify the `kmsKeyId`, or you specify an empty string, then the
    ///   access preview uses the existing `kmsKeyId` of the snapshot.
    /// * If the access preview is for a new resource and you do not specify the
    ///   specify the `kmsKeyId`, then the access preview considers the snapshot as
    ///   unencrypted.
    kms_key_id: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .kms_key_id = "kmsKeyId",
    };
};
