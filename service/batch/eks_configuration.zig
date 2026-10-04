const EksAccessEntry = @import("eks_access_entry.zig").EksAccessEntry;

/// Configuration for the Amazon EKS cluster that supports the Batch compute
/// environment. The
/// cluster must exist before the compute environment can be created.
pub const EksConfiguration = struct {
    /// The Batch-managed Amazon EKS access entry for the compute environment. Set
    /// `desiredState` to declare whether Batch manages an access entry on the
    /// cluster. In
    /// a `DescribeComputeEnvironments` response, `desiredState` is the value that
    /// Batch recorded for the compute environment and `status` is the observed
    /// state of
    /// the access entry on the cluster. To change the access entry on an existing
    /// compute environment,
    /// use [
    /// `EksConfigurationUpdate.accessEntry`
    /// ](https://docs.aws.amazon.com/batch/latest/APIReference/API_EksConfigurationUpdate.html#Batch-Type-EksConfigurationUpdate-accessEntry).
    ///
    /// Whether the entry is provisioned on the cluster depends on the cluster's
    /// `authenticationMode` and the `desiredState` recorded for each Batch compute
    /// environment targeting the cluster. For more information,
    /// see [Amazon EKS access entry
    /// authentication](https://docs.aws.amazon.com/batch/latest/userguide/eks-access-entries.html) in the *Batch User Guide*.
    ///
    /// If you don't specify this field, Batch doesn't record a `desiredState` for
    /// the
    /// compute environment and `DescribeComputeEnvironments` doesn't return one.
    /// For the
    /// purpose of provisioning the access entry, Batch behaves as it does for
    /// `INHERIT_FROM_CLUSTER`.
    access_entry: ?EksAccessEntry = null,

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
        .access_entry = "accessEntry",
        .eks_cluster_arn = "eksClusterArn",
        .kubernetes_namespace = "kubernetesNamespace",
    };
};
