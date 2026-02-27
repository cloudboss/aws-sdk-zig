/// The upper and lower Amazon EC2 instance limits for an automatic scaling
/// policy.
/// Automatic scaling activities triggered by automatic scaling rules will not
/// cause an
/// instance group to grow above or below these limits.
pub const ScalingConstraints = struct {
    /// The upper boundary of Amazon EC2 instances in an instance group beyond which
    /// scaling activities are not allowed to grow. Scale-out activities will not
    /// add instances
    /// beyond this boundary.
    max_capacity: i32,

    /// The lower boundary of Amazon EC2 instances in an instance group below which
    /// scaling activities are not allowed to shrink. Scale-in activities will not
    /// terminate
    /// instances below this boundary.
    min_capacity: i32,

    pub const json_field_names = .{
        .max_capacity = "MaxCapacity",
        .min_capacity = "MinCapacity",
    };
};
