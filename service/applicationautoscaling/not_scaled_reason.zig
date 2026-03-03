/// Describes the reason for an activity that isn't scaled (*not scaled
/// activity*), in machine-readable format. For help interpreting the not scaled
/// reason details, see [Scaling activities for Application Auto
/// Scaling](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-scaling-activities.html) in the
/// *Application Auto Scaling User Guide*.
pub const NotScaledReason = struct {
    /// A code that represents the reason for not scaling.
    ///
    /// Valid values:
    ///
    /// * AutoScalingAnticipatedFlapping
    ///
    /// * TargetServicePutResourceAsUnscalable
    ///
    /// * AlreadyAtMaxCapacity
    ///
    /// * AlreadyAtMinCapacity
    ///
    /// * AlreadyAtDesiredCapacity
    code: []const u8,

    /// The current capacity.
    current_capacity: ?i32 = null,

    /// The maximum capacity.
    max_capacity: ?i32 = null,

    /// The minimum capacity.
    min_capacity: ?i32 = null,

    pub const json_field_names = .{
        .code = "Code",
        .current_capacity = "CurrentCapacity",
        .max_capacity = "MaxCapacity",
        .min_capacity = "MinCapacity",
    };
};
