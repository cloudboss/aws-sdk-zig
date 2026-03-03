/// Describes an EBS volume for a Scheduled Instance.
pub const ScheduledInstancesEbs = struct {
    /// Indicates whether the volume is deleted on instance termination.
    delete_on_termination: ?bool = null,

    /// Indicates whether the volume is encrypted. You can attached encrypted
    /// volumes only to instances that
    /// support them.
    encrypted: ?bool = null,

    /// The number of I/O operations per second (IOPS) to provision for a `gp3`,
    /// `io1`, or `io2`
    /// volume.
    iops: ?i32 = null,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8 = null,

    /// The size of the volume, in GiB.
    ///
    /// Default: If you're creating the volume from a snapshot and don't specify a
    /// volume size, the default
    /// is the snapshot size.
    volume_size: ?i32 = null,

    /// The volume type.
    ///
    /// Default: `gp2`
    volume_type: ?[]const u8 = null,
};
