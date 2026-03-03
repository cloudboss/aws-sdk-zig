/// Describes an Amazon Web Services Identity and Access Management (IAM) role
/// that is associated with a DB cluster.
pub const DBClusterRole = struct {
    /// The name of the feature associated with the Amazon Web Services Identity and
    /// Access Management (IAM) role. For information about supported feature names,
    /// see DBEngineVersion.
    feature_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that is associated with the
    /// DB cluster.
    role_arn: ?[]const u8 = null,

    /// Describes the state of association between the IAM role and the DB cluster.
    /// The Status property returns one of the following values:
    ///
    /// * `ACTIVE` - the IAM role ARN is associated with the DB cluster and can be
    ///   used to access other Amazon Web Services on your behalf.
    /// * `PENDING` - the IAM role ARN is being associated with the DB cluster.
    /// * `INVALID` - the IAM role ARN is associated with the DB cluster, but the DB
    ///   cluster is unable to assume the IAM role in order to access other Amazon
    ///   Web Services on your behalf.
    status: ?[]const u8 = null,
};
