/// Specifies the minimum and maximum for the `AcceleratorCount` object when
/// you specify
/// [InstanceRequirements](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_InstanceRequirements.html) for an Auto Scaling group.
pub const AcceleratorCountRequest = struct {
    /// The maximum value.
    max: ?i32,

    /// The minimum value.
    min: ?i32,
};
