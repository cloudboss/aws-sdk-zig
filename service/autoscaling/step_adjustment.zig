/// Describes information used to create a step adjustment for a step scaling
/// policy.
///
/// For the following examples, suppose that you have an alarm with a breach
/// threshold of
/// 50:
///
/// * To trigger the adjustment when the metric is greater than or equal to 50
///   and
/// less than 60, specify a lower bound of 0 and an upper bound of 10.
///
/// * To trigger the adjustment when the metric is greater than 40 and less than
///   or
/// equal to 50, specify a lower bound of -10 and an upper bound of 0.
///
/// There are a few rules for the step adjustments for your step policy:
///
/// * The ranges of your step adjustments can't overlap or have a gap.
///
/// * At most, one step adjustment can have a null lower bound. If one step
/// adjustment has a negative lower bound, then there must be a step adjustment
/// with
/// a null lower bound.
///
/// * At most, one step adjustment can have a null upper bound. If one step
/// adjustment has a positive upper bound, then there must be a step adjustment
/// with
/// a null upper bound.
///
/// * The upper and lower bound can't be null in the same step adjustment.
///
/// For more information, see [Step
/// adjustments](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-simple-step.html#as-scaling-steps) in the *Amazon EC2 Auto Scaling User Guide*.
pub const StepAdjustment = struct {
    /// The lower bound for the difference between the alarm threshold and the
    /// CloudWatch metric. If
    /// the metric value is above the breach threshold, the lower bound is inclusive
    /// (the metric
    /// must be greater than or equal to the threshold plus the lower bound).
    /// Otherwise, it is
    /// exclusive (the metric must be greater than the threshold plus the lower
    /// bound). A null
    /// value indicates negative infinity.
    metric_interval_lower_bound: ?f64 = null,

    /// The upper bound for the difference between the alarm threshold and the
    /// CloudWatch metric. If
    /// the metric value is above the breach threshold, the upper bound is exclusive
    /// (the metric
    /// must be less than the threshold plus the upper bound). Otherwise, it is
    /// inclusive (the
    /// metric must be less than or equal to the threshold plus the upper bound). A
    /// null value
    /// indicates positive infinity.
    ///
    /// The upper bound must be greater than the lower bound.
    metric_interval_upper_bound: ?f64 = null,

    /// The amount by which to scale, based on the specified adjustment type. A
    /// positive value
    /// adds to the current capacity while a negative number removes from the
    /// current capacity.
    /// For exact capacity, you must specify a non-negative value.
    scaling_adjustment: i32,
};
