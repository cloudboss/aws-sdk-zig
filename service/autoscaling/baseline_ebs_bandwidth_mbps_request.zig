/// Specifies the minimum and maximum for the `BaselineEbsBandwidthMbps` object
/// when you specify
/// [InstanceRequirements](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_InstanceRequirements.html) for an Auto Scaling group.
pub const BaselineEbsBandwidthMbpsRequest = struct {
    /// The maximum value in Mbps.
    max: ?i32 = null,

    /// The minimum value in Mbps.
    min: ?i32 = null,
};
