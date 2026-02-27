const ClusterOrchestratorEksConfig = @import("cluster_orchestrator_eks_config.zig").ClusterOrchestratorEksConfig;

/// The type of orchestrator used for the SageMaker HyperPod cluster.
pub const ClusterOrchestrator = struct {
    /// The Amazon EKS cluster used as the orchestrator for the SageMaker HyperPod
    /// cluster.
    eks: ?ClusterOrchestratorEksConfig,

    pub const json_field_names = .{
        .eks = "Eks",
    };
};
