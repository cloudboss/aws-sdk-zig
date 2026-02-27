/// Specifies the minimum and maximum for the `MemoryMiB` object when you
/// specify
/// [InstanceRequirements](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_InstanceRequirements.html) for an Auto Scaling group.
pub const MemoryMiBRequest = struct {
    /// The memory maximum in MiB.
    max: ?i32,

    /// The memory minimum in MiB.
    min: i32,
};
