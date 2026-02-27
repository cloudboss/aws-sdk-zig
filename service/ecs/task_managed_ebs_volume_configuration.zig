const TaskFilesystemType = @import("task_filesystem_type.zig").TaskFilesystemType;
const EBSTagSpecification = @import("ebs_tag_specification.zig").EBSTagSpecification;
const TaskManagedEBSVolumeTerminationPolicy = @import("task_managed_ebs_volume_termination_policy.zig").TaskManagedEBSVolumeTerminationPolicy;

/// The configuration for the Amazon EBS volume that Amazon ECS creates and
/// manages on
/// your behalf. These settings are used to create each Amazon EBS volume, with
/// one volume
/// created for each task.
pub const TaskManagedEBSVolumeConfiguration = struct {
    /// Indicates whether the volume should be encrypted. If you turn on
    /// Region-level Amazon
    /// EBS encryption by default but set this value as `false`, the setting is
    /// overridden and the volume is encrypted with the KMS key specified for Amazon
    /// EBS
    /// encryption by default. This parameter maps 1:1 with the `Encrypted`
    /// parameter
    /// of the [CreateVolume
    /// API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in
    /// the *Amazon EC2 API Reference*.
    encrypted: ?bool,

    /// The Linux filesystem type for the volume. For volumes created from a
    /// snapshot, you
    /// must specify the same filesystem type that the volume was using when the
    /// snapshot was
    /// created. If there is a filesystem type mismatch, the task will fail to
    /// start.
    ///
    /// The available filesystem types are  `ext3`, `ext4`, and
    /// `xfs`. If no value is specified, the `xfs` filesystem type is
    /// used by default.
    filesystem_type: ?TaskFilesystemType,

    /// The number of I/O operations per second (IOPS). For `gp3`,
    /// `io1`, and `io2` volumes, this represents the number of IOPS that
    /// are provisioned for the volume. For `gp2` volumes, this represents the
    /// baseline performance of the volume and the rate at which the volume
    /// accumulates I/O
    /// credits for bursting.
    ///
    /// The following are the supported values for each volume type.
    ///
    /// * `gp3`: 3,000 - 16,000 IOPS
    ///
    /// * `io1`: 100 - 64,000 IOPS
    ///
    /// * `io2`: 100 - 256,000 IOPS
    ///
    /// This parameter is required for `io1` and `io2` volume types. The
    /// default for `gp3` volumes is `3,000 IOPS`. This parameter is not
    /// supported for `st1`, `sc1`, or `standard` volume
    /// types.
    ///
    /// This parameter maps 1:1 with the `Iops` parameter of the [CreateVolume
    /// API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API
    /// Reference*.
    iops: ?i32,

    /// The Amazon Resource Name (ARN) identifier of the Amazon Web Services Key
    /// Management Service key
    /// to use for Amazon EBS encryption. When a key is specified using this
    /// parameter, it
    /// overrides Amazon EBS default encryption or any KMS key that you specified
    /// for
    /// cluster-level managed storage encryption. This parameter maps 1:1 with the
    /// `KmsKeyId` parameter of the [CreateVolume
    /// API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in
    /// the *Amazon EC2 API Reference*. For more information about encrypting
    /// Amazon EBS volumes attached to a task, see [Encrypt data stored in Amazon
    /// EBS volumes attached to Amazon ECS
    /// tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ebs-kms-encryption.html).
    ///
    /// Amazon Web
    /// Services authenticates the Amazon Web Services Key Management Service
    /// key asynchronously. Therefore, if you specify an ID, alias, or ARN that is
    /// invalid,
    /// the action can appear to complete, but eventually fails.
    kms_key_id: ?[]const u8,

    /// The ARN of the IAM role to associate with this volume. This is the Amazon
    /// ECS
    /// infrastructure IAM role that is used to manage your Amazon Web Services
    /// infrastructure. We
    /// recommend using the Amazon ECS-managed
    /// `AmazonECSInfrastructureRolePolicyForVolumes` IAM policy with this role.
    /// For more information, see [Amazon ECS
    /// infrastructure IAM
    /// role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/infrastructure_IAM_role.html) in the *Amazon ECS Developer
    /// Guide*.
    role_arn: []const u8,

    /// The size of the volume in GiB. You must specify either a volume size or a
    /// snapshot ID.
    /// If you specify a snapshot ID, the snapshot size is used for the volume size
    /// by default.
    /// You can optionally specify a volume size greater than or equal to the
    /// snapshot size.
    /// This parameter maps 1:1 with the `Size` parameter of the [CreateVolume
    /// API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API
    /// Reference*.
    ///
    /// The following are the supported volume size values for each volume type.
    ///
    /// * `gp2` and `gp3`: 1-16,384
    ///
    /// * `io1` and `io2`: 4-16,384
    ///
    /// * `st1` and `sc1`: 125-16,384
    ///
    /// * `standard`: 1-1,024
    size_in_gi_b: ?i32,

    /// The snapshot that Amazon ECS uses to create the volume. You must specify
    /// either a
    /// snapshot ID or a volume size. This parameter maps 1:1 with the `SnapshotId`
    /// parameter of the [CreateVolume
    /// API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in
    /// the *Amazon EC2 API Reference*.
    snapshot_id: ?[]const u8,

    /// The tags to apply to the volume. Amazon ECS applies service-managed tags by
    /// default.
    /// This parameter maps 1:1 with the `TagSpecifications.N` parameter of the
    /// [CreateVolume
    /// API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API
    /// Reference*.
    tag_specifications: ?[]const EBSTagSpecification,

    /// The termination policy for the volume when the task exits. This provides a
    /// way to
    /// control whether Amazon ECS terminates the Amazon EBS volume when the task
    /// stops.
    termination_policy: ?TaskManagedEBSVolumeTerminationPolicy,

    /// The throughput to provision for a volume, in MiB/s, with a maximum of 1,000
    /// MiB/s.
    /// This parameter maps 1:1 with the `Throughput` parameter of the [CreateVolume
    /// API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API
    /// Reference*.
    ///
    /// This parameter is only supported for the `gp3` volume type.
    throughput: ?i32,

    /// The rate, in MiB/s, at which data is fetched from a snapshot of an existing
    /// Amazon EBS
    /// volume to create a new volume for attachment to the task. This property can
    /// be specified
    /// only if you specify a `snapshotId`. For more information, see [Initialize
    /// Amazon EBS
    /// volumes](https://docs.aws.amazon.com/ebs/latest/userguide/initalize-volume.html) in the *Amazon EBS User Guide*.
    volume_initialization_rate: ?i32,

    /// The volume type. This parameter maps 1:1 with the `VolumeType` parameter of
    /// the [CreateVolume
    /// API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API Reference*. For
    /// more information, see [Amazon EBS volume
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html)
    /// in the *Amazon EC2 User Guide*.
    ///
    /// The following are the supported volume types.
    ///
    /// * General Purpose SSD: `gp2`|`gp3`
    ///
    /// * Provisioned IOPS SSD: `io1`|`io2`
    ///
    /// * Throughput Optimized HDD: `st1`
    ///
    /// * Cold HDD: `sc1`
    ///
    /// * Magnetic: `standard`
    ///
    /// The magnetic volume type is not supported on Fargate.
    volume_type: ?[]const u8,

    pub const json_field_names = .{
        .encrypted = "encrypted",
        .filesystem_type = "filesystemType",
        .iops = "iops",
        .kms_key_id = "kmsKeyId",
        .role_arn = "roleArn",
        .size_in_gi_b = "sizeInGiB",
        .snapshot_id = "snapshotId",
        .tag_specifications = "tagSpecifications",
        .termination_policy = "terminationPolicy",
        .throughput = "throughput",
        .volume_initialization_rate = "volumeInitializationRate",
        .volume_type = "volumeType",
    };
};
