/// The configuration settings for the Amazon EKS cluster used as the
/// orchestrator for the SageMaker HyperPod cluster.
pub const ClusterOrchestratorEksConfig = struct {
    /// The Amazon Resource Name (ARN) of the Amazon EKS cluster associated with the
    /// SageMaker HyperPod cluster.
    cluster_arn: []const u8,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
    };
};
