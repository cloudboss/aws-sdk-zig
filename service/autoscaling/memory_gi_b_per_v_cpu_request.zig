/// Specifies the minimum and maximum for the `MemoryGiBPerVCpu` object when
/// you specify
/// [InstanceRequirements](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_InstanceRequirements.html) for an Auto Scaling group.
pub const MemoryGiBPerVCpuRequest = struct {
    /// The memory maximum in GiB.
    max: ?f64,

    /// The memory minimum in GiB.
    min: ?f64,
};
