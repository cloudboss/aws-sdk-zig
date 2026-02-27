const ClusterEbsVolumeConfig = @import("cluster_ebs_volume_config.zig").ClusterEbsVolumeConfig;

/// Defines the configuration for attaching additional storage to the instances
/// in the SageMaker HyperPod cluster instance group. To learn more, see
/// [SageMaker HyperPod release notes: June 20,
/// 2024](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-release-notes.html#sagemaker-hyperpod-release-notes-20240620).
pub const ClusterInstanceStorageConfig = union(enum) {
    /// Defines the configuration for attaching additional Amazon Elastic Block
    /// Store (EBS) volumes to the instances in the SageMaker HyperPod cluster
    /// instance group. The additional EBS volume is attached to each instance
    /// within the SageMaker HyperPod cluster instance group and mounted to
    /// `/opt/sagemaker`.
    ebs_volume_config: ?ClusterEbsVolumeConfig,

    pub const json_field_names = .{
        .ebs_volume_config = "EbsVolumeConfig",
    };
};
