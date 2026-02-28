const CostEstimationServiceResourceState = @import("cost_estimation_service_resource_state.zig").CostEstimationServiceResourceState;

/// An object that contains information about the estimated monthly cost to
/// analyze an
/// Amazon Web Services resource. For more information,
/// see [Estimate your
/// Amazon DevOps Guru
/// costs](https://docs.aws.amazon.com/devops-guru/latest/userguide/cost-estimate.html) and
/// [Amazon DevOps Guru pricing](http://aws.amazon.com/devops-guru/pricing/).
pub const ServiceResourceCost = struct {
    /// The total estimated monthly cost to analyze the active resources for this
    /// resource.
    cost: f64 = 0,

    /// The number of active resources analyzed for this service to create a monthly
    /// cost
    /// estimate.
    count: i32 = 0,

    /// The state of the resource. The resource is `ACTIVE` if it produces metrics,
    /// events, or logs within an hour, otherwise it is `INACTIVE`. You pay for the
    /// number of active Amazon Web Services resource hours analyzed for each
    /// resource. Inactive resources are
    /// not charged.
    state: ?CostEstimationServiceResourceState,

    /// The type of the Amazon Web Services resource.
    @"type": ?[]const u8,

    /// The price per hour to analyze the resources in the service.
    /// For more information,
    /// see [Estimate your
    /// Amazon DevOps Guru
    /// costs](https://docs.aws.amazon.com/devops-guru/latest/userguide/cost-estimate.html) and
    /// [Amazon DevOps Guru pricing](http://aws.amazon.com/devops-guru/pricing/).
    unit_cost: f64 = 0,

    pub const json_field_names = .{
        .cost = "Cost",
        .count = "Count",
        .state = "State",
        .@"type" = "Type",
        .unit_cost = "UnitCost",
    };
};
