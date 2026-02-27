/// The input source of the Amazon Elastic Kubernetes Service cluster.
pub const EksSource = struct {
    /// Amazon Resource Name (ARN) of the Amazon Elastic Kubernetes Service cluster.
    /// The format for this ARN is:
    /// arn:`aws`:eks:`region`:`account-id`:cluster/`cluster-name`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    eks_cluster_arn: []const u8,

    /// The list of namespaces located on your Amazon Elastic Kubernetes Service
    /// cluster.
    namespaces: []const []const u8,

    pub const json_field_names = .{
        .eks_cluster_arn = "eksClusterArn",
        .namespaces = "namespaces",
    };
};
