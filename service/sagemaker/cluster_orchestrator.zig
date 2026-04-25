const ClusterOrchestratorEksConfig = @import("cluster_orchestrator_eks_config.zig").ClusterOrchestratorEksConfig;
const ClusterOrchestratorSlurmConfig = @import("cluster_orchestrator_slurm_config.zig").ClusterOrchestratorSlurmConfig;

/// The type of orchestrator used for the SageMaker HyperPod cluster.
pub const ClusterOrchestrator = struct {
    /// The Amazon EKS cluster used as the orchestrator for the SageMaker HyperPod
    /// cluster.
    eks: ?ClusterOrchestratorEksConfig = null,

    /// The Slurm orchestrator configuration for the SageMaker HyperPod cluster.
    slurm: ?ClusterOrchestratorSlurmConfig = null,

    pub const json_field_names = .{
        .eks = "Eks",
        .slurm = "Slurm",
    };
};
