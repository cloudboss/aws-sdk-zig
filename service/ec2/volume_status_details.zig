const VolumeStatusName = @import("volume_status_name.zig").VolumeStatusName;

/// Describes a volume status.
pub const VolumeStatusDetails = struct {
    /// The name of the volume status.
    ///
    /// * `io-enabled` - Indicates the volume I/O status. For more
    /// information, see [Amazon EBS volume
    /// status
    /// checks](https://docs.aws.amazon.com/ebs/latest/userguide/monitoring-volume-checks.html).
    ///
    /// * `io-performance` - Indicates the volume performance status.
    /// For more information, see [Amazon EBS volume
    /// status
    /// checks](https://docs.aws.amazon.com/ebs/latest/userguide/monitoring-volume-checks.html).
    ///
    /// * `initialization-state` - Indicates the status of the volume
    /// initialization process. For more information, see [Initialize Amazon EBS
    /// volumes](https://docs.aws.amazon.com/ebs/latest/userguide/initalize-volume.html).
    name: ?VolumeStatusName,

    /// The intended status of the volume status.
    status: ?[]const u8,
};
