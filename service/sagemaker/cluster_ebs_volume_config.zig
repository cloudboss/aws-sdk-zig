/// Defines the configuration for attaching an additional Amazon Elastic Block
/// Store (EBS) volume to each instance of the SageMaker HyperPod cluster
/// instance group. To learn more, see [SageMaker HyperPod release notes: June
/// 20,
/// 2024](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-release-notes.html#sagemaker-hyperpod-release-notes-20240620).
pub const ClusterEbsVolumeConfig = struct {
    /// Specifies whether the configuration is for the cluster's root or secondary
    /// Amazon EBS volume. You can specify two `ClusterEbsVolumeConfig` fields to
    /// configure both the root and secondary volumes. Set the value to `True` if
    /// you'd like to provide your own customer managed Amazon Web Services KMS key
    /// to encrypt the root volume. When `True`:
    ///
    /// * The configuration is applied to the root volume.
    /// * You can't specify the `VolumeSizeInGB` field. The size of the root volume
    ///   is determined for you.
    /// * You must specify a KMS key ID for `VolumeKmsKeyId` to encrypt the root
    ///   volume with your own KMS key instead of an Amazon Web Services owned KMS
    ///   key.
    ///
    /// Otherwise, by default, the value is `False`, and the following applies:
    ///
    /// * The configuration is applied to the secondary volume, while the root
    ///   volume is encrypted with an Amazon Web Services owned key.
    /// * You must specify the `VolumeSizeInGB` field.
    /// * You can optionally specify the `VolumeKmsKeyId` to encrypt the secondary
    ///   volume with your own KMS key instead of an Amazon Web Services owned KMS
    ///   key.
    root_volume: ?bool,

    /// The ID of a KMS key to encrypt the Amazon EBS volume.
    volume_kms_key_id: ?[]const u8,

    /// The size in gigabytes (GB) of the additional EBS volume to be attached to
    /// the instances in the SageMaker HyperPod cluster instance group. The
    /// additional EBS volume is attached to each instance within the SageMaker
    /// HyperPod cluster instance group and mounted to `/opt/sagemaker`.
    volume_size_in_gb: ?i32,

    pub const json_field_names = .{
        .root_volume = "RootVolume",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};
