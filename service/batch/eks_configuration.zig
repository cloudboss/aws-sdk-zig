/// Configuration for the Amazon EKS cluster that supports the Batch compute
/// environment. The
/// cluster must exist before the compute environment can be created.
pub const EksConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Amazon EKS cluster. An example is
    /// `arn:*aws*:eks:*us-east-1*:*123456789012*:cluster/*ClusterForBatch*
    /// `.
    eks_cluster_arn: []const u8,

    /// The namespace of the Amazon EKS cluster. Batch manages pods in this
    /// namespace. The value
    /// can't left empty or null. It must be fewer than 64 characters long, can't be
    /// set to
    /// `default`, can't start with "`kube-`," and must match this regular
    /// expression: `^[a-z0-9]([-a-z0-9]*[a-z0-9])?$`. For more information, see
    /// [Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) in the Kubernetes documentation.
    kubernetes_namespace: []const u8,

    pub const json_field_names = .{
        .eks_cluster_arn = "eksClusterArn",
        .kubernetes_namespace = "kubernetesNamespace",
    };
};
