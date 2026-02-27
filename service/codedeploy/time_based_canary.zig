/// A configuration that shifts traffic from one version of a Lambda function
/// or Amazon ECS task set to another in two increments. The original and target
/// Lambda function versions or ECS task sets are specified in the
/// deployment's AppSpec file.
pub const TimeBasedCanary = struct {
    /// The number of minutes between the first and second traffic shifts of a
    /// `TimeBasedCanary` deployment.
    canary_interval: i32 = 0,

    /// The percentage of traffic to shift in the first increment of a
    /// `TimeBasedCanary` deployment.
    canary_percentage: i32 = 0,

    pub const json_field_names = .{
        .canary_interval = "canaryInterval",
        .canary_percentage = "canaryPercentage",
    };
};
