/// Parameters that are used to automatically set up EBS volumes when an
/// instance is launched.
pub const AwsAutoScalingLaunchConfigurationBlockDeviceMappingsEbsDetails = struct {
    /// Whether to delete the volume when the instance is terminated.
    delete_on_termination: ?bool = null,

    /// Whether to encrypt the volume.
    encrypted: ?bool = null,

    /// The number of input/output (I/O) operations per second (IOPS) to provision
    /// for the volume.
    ///
    /// Only supported for `gp3` or `io1` volumes. Required for `io1` volumes. Not
    /// used with `standard`, `gp2`, `st1`, or `sc1` volumes.
    iops: ?i32 = null,

    /// The snapshot ID of the volume to use.
    ///
    /// You must specify either `VolumeSize` or `SnapshotId`.
    snapshot_id: ?[]const u8 = null,

    /// The volume size, in GiBs. The following are the supported volumes sizes for
    /// each volume type:
    ///
    /// * gp2 and gp3: 1-16,384
    ///
    /// * io1: 4-16,384
    ///
    /// * st1 and sc1: 125-16,384
    ///
    /// * standard: 1-1,024
    ///
    /// You must specify either `SnapshotId` or `VolumeSize`. If you specify both
    /// `SnapshotId` and `VolumeSize`, the volume size must be equal or greater than
    /// the size of the snapshot.
    volume_size: ?i32 = null,

    /// The volume type. Valid values are as follows:
    ///
    /// * `gp2`
    ///
    /// * `gp3`
    ///
    /// * `io1`
    ///
    /// * `sc1`
    ///
    /// * `st1`
    ///
    /// * `standard`
    volume_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .delete_on_termination = "DeleteOnTermination",
        .encrypted = "Encrypted",
        .iops = "Iops",
        .snapshot_id = "SnapshotId",
        .volume_size = "VolumeSize",
        .volume_type = "VolumeType",
    };
};
