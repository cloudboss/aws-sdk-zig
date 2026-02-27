/// A configuration that shifts traffic from one version of a Lambda function
/// or ECS task set to another in equal increments, with an equal number of
/// minutes between
/// each increment. The original and target Lambda function versions or ECS task
/// sets are specified in the deployment's AppSpec file.
pub const TimeBasedLinear = struct {
    /// The number of minutes between each incremental traffic shift of a
    /// `TimeBasedLinear` deployment.
    linear_interval: i32 = 0,

    /// The percentage of traffic that is shifted at the start of each increment of
    /// a
    /// `TimeBasedLinear` deployment.
    linear_percentage: i32 = 0,

    pub const json_field_names = .{
        .linear_interval = "linearInterval",
        .linear_percentage = "linearPercentage",
    };
};
