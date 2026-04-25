const ClusterEbsVolumeConfig = @import("cluster_ebs_volume_config.zig").ClusterEbsVolumeConfig;
const ClusterFsxLustreConfig = @import("cluster_fsx_lustre_config.zig").ClusterFsxLustreConfig;
const ClusterFsxOpenZfsConfig = @import("cluster_fsx_open_zfs_config.zig").ClusterFsxOpenZfsConfig;

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
    /// Defines the configuration for attaching an Amazon FSx for Lustre file system
    /// to the instances in the SageMaker HyperPod cluster instance group.
    fsx_lustre_config: ?ClusterFsxLustreConfig,
    /// Defines the configuration for attaching an Amazon FSx for OpenZFS file
    /// system to the instances in the SageMaker HyperPod cluster instance group.
    fsx_open_zfs_config: ?ClusterFsxOpenZfsConfig,

    pub const json_field_names = .{
        .ebs_volume_config = "EbsVolumeConfig",
        .fsx_lustre_config = "FsxLustreConfig",
        .fsx_open_zfs_config = "FsxOpenZfsConfig",
    };
};
