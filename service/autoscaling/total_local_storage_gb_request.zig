/// Specifies the minimum and maximum for the `TotalLocalStorageGB` object when
/// you specify
/// [InstanceRequirements](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_InstanceRequirements.html) for an Auto Scaling group.
pub const TotalLocalStorageGBRequest = struct {
    /// The storage maximum in GB.
    max: ?f64 = null,

    /// The storage minimum in GB.
    min: ?f64 = null,
};
