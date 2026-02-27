/// Describes an Amazon Identity and Access Management (IAM) role that is
/// associated with a DB
/// cluster.
pub const DBClusterRole = struct {
    /// The name of the feature associated with the Amazon Identity and Access
    /// Management (IAM) role.
    /// For the list of supported feature names, see DescribeDBEngineVersions.
    feature_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that is associated with the
    /// DB
    /// cluster.
    role_arn: ?[]const u8,

    /// Describes the state of association between the IAM role and the DB cluster.
    /// The Status
    /// property returns one of the following values:
    ///
    /// * `ACTIVE` - the IAM role ARN is associated with the DB cluster and can be
    /// used to access other Amazon services on your behalf.
    ///
    /// * `PENDING` - the IAM role ARN is being associated with the DB
    /// cluster.
    ///
    /// * `INVALID` - the IAM role ARN is associated with the DB cluster, but the DB
    /// cluster is unable to assume the IAM role in order to access other Amazon
    /// services on your
    /// behalf.
    status: ?[]const u8,
};
