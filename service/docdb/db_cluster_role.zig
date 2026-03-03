/// Describes an Identity and Access Management (IAM) role that is associated
/// with a
/// cluster.
pub const DBClusterRole = struct {
    /// The Amazon Resource Name (ARN) of the IAMrole that is associated with the DB
    /// cluster.
    role_arn: ?[]const u8 = null,

    /// Describes the state of association between the IAMrole and the cluster. The
    /// `Status` property returns one of the following values:
    ///
    /// * `ACTIVE` - The IAMrole ARN is associated with the cluster and can be used
    ///   to access other Amazon Web Services services on your behalf.
    ///
    /// * `PENDING` - The IAMrole ARN is being associated with the cluster.
    ///
    /// * `INVALID` - The IAMrole ARN is associated with the cluster, but the
    ///   cluster cannot assume the IAMrole to access other Amazon Web Services
    ///   services on your behalf.
    status: ?[]const u8 = null,
};
