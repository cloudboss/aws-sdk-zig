/// Describes an instance reuse policy for a warm pool.
///
/// For more information, see [Warm pools for
/// Amazon EC2 Auto
/// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-warm-pools.html) in the *Amazon EC2 Auto Scaling User Guide*.
pub const InstanceReusePolicy = struct {
    /// Specifies whether instances in the Auto Scaling group can be returned to the
    /// warm pool on
    /// scale in.
    reuse_on_scale_in: ?bool = null,
};
