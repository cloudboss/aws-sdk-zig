/// An Identity and Access Management (IAM) role that can be used by the
/// associated
/// Amazon Redshift cluster to access other Amazon Web Services services.
pub const ClusterIamRole = struct {
    /// A value that describes the status of the IAM role's association with an
    /// Amazon
    /// Redshift cluster.
    ///
    /// The following are possible statuses and descriptions.
    ///
    /// * `in-sync`: The role is available for use by the cluster.
    ///
    /// * `adding`: The role is in the process of being associated with the
    /// cluster.
    ///
    /// * `removing`: The role is in the process of being disassociated with
    /// the cluster.
    apply_status: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role, for example,
    /// `arn:aws:iam::123456789012:role/RedshiftCopyUnload`.
    iam_role_arn: ?[]const u8 = null,
};
