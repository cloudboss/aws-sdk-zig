const aws = @import("aws");

const RdsDbClusterSnapshotAttributeValue = @import("rds_db_cluster_snapshot_attribute_value.zig").RdsDbClusterSnapshotAttributeValue;

/// The proposed access control configuration for an Amazon RDS DB cluster
/// snapshot. You can propose a configuration for a new Amazon RDS DB cluster
/// snapshot or an Amazon RDS DB cluster snapshot that you own by specifying the
/// `RdsDbClusterSnapshotAttributeValue` and optional KMS encryption key. For
/// more information, see
/// [ModifyDBClusterSnapshotAttribute](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_ModifyDBClusterSnapshotAttribute.html).
pub const RdsDbClusterSnapshotConfiguration = struct {
    /// The names and values of manual DB cluster snapshot attributes. Manual DB
    /// cluster snapshot attributes are used to authorize other Amazon Web Services
    /// accounts to restore a manual DB cluster snapshot. The only valid value for
    /// `AttributeName` for the attribute map is `restore`
    attributes: ?[]const aws.map.MapEntry(RdsDbClusterSnapshotAttributeValue) = null,

    /// The KMS key identifier for an encrypted Amazon RDS DB cluster snapshot. The
    /// KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the
    /// KMS key.
    ///
    /// * If the configuration is for an existing Amazon RDS DB cluster snapshot and
    ///   you do not specify the `kmsKeyId`, or you specify an empty string, then
    ///   the access preview uses the existing `kmsKeyId` of the snapshot.
    /// * If the access preview is for a new resource and you do not specify the
    ///   specify the `kmsKeyId`, then the access preview considers the snapshot as
    ///   unencrypted.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .kms_key_id = "kmsKeyId",
    };
};
