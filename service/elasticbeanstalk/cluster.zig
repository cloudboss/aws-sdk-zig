/// Describes the Amazon EKS cluster that an environment runs on.
pub const Cluster = struct {
    /// The Amazon Resource Name (ARN) of the Amazon EKS cluster.
    cluster_arn: ?[]const u8 = null,
};
