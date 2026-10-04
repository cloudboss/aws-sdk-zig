/// Contains information about an Amazon Web Services Identity and Access
/// Management (IAM) role to associate with a DB cluster. You can specify this
/// structure in the `AssociatedRoles` parameter of CreateDBCluster,
/// RestoreDBClusterFromS3, RestoreDBClusterFromSnapshot, and
/// RestoreDBClusterToPointInTime.
pub const DBClusterAssociatedRole = struct {
    /// The name of the feature associated with the IAM role. For information about
    /// supported feature names, see DBEngineVersion.
    feature_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role to associate with the DB
    /// cluster.
    role_arn: []const u8,
};
