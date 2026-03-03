/// Specifies the minimum and maximum for the `VCpuCount` object when you
/// specify
/// [InstanceRequirements](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_InstanceRequirements.html) for an Auto Scaling group.
pub const VCpuCountRequest = struct {
    /// The maximum number of vCPUs.
    max: ?i32 = null,

    /// The minimum number of vCPUs.
    min: i32,
};
