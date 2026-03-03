const Ebs = @import("ebs.zig").Ebs;

/// Describes a block device mapping.
pub const BlockDeviceMapping = struct {
    /// The device name assigned to the volume (for example, `/dev/sdh` or
    /// `xvdh`). For more information, see [Device naming on Linux
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html) in the *Amazon EC2 User Guide*.
    ///
    /// To define a block device mapping, set the device name and exactly one of the
    /// following properties: `Ebs`, `NoDevice`, or
    /// `VirtualName`.
    device_name: []const u8,

    /// Information to attach an EBS volume to an instance at launch.
    ebs: ?Ebs = null,

    /// Setting this value to `true` prevents a volume that is included in the
    /// block device mapping of the AMI from being mapped to the specified device
    /// name at
    /// launch.
    ///
    /// If `NoDevice` is `true` for the root device, instances might
    /// fail the EC2 health check. In that case, Amazon EC2 Auto Scaling launches
    /// replacement instances.
    no_device: ?bool = null,

    /// The name of the instance store volume (virtual device) to attach to an
    /// instance at
    /// launch. The name must be in the form ephemeral*X* where
    /// *X* is a number starting from zero (0), for example,
    /// `ephemeral0`.
    virtual_name: ?[]const u8 = null,
};
