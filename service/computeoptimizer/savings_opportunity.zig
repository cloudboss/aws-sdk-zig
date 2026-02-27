const EstimatedMonthlySavings = @import("estimated_monthly_savings.zig").EstimatedMonthlySavings;

/// Describes the savings opportunity for recommendations of a given resource
/// type or for
/// the recommendation option of an individual resource.
///
/// Savings opportunity represents the estimated monthly savings you can achieve
/// by
/// implementing a given Compute Optimizer recommendation.
///
/// Savings opportunity data requires that you opt in to Cost Explorer, as well
/// as
/// activate **Receive Amazon EC2 resource
/// recommendations** in the Cost Explorer preferences page. That
/// creates a connection between Cost Explorer and Compute Optimizer. With this
/// connection, Cost Explorer generates savings estimates considering the price
/// of
/// existing resources, the price of recommended resources, and historical usage
/// data.
/// Estimated monthly savings reflects the projected dollar savings associated
/// with each
/// of the recommendations generated. For more information, see [Enabling Cost
/// Explorer](https://docs.aws.amazon.com/cost-management/latest/userguide/ce-enable.html) and [Optimizing your cost
/// with Rightsizing
/// Recommendations](https://docs.aws.amazon.com/cost-management/latest/userguide/ce-rightsizing.html) in the *Cost Management User
/// Guide*.
pub const SavingsOpportunity = struct {
    /// An object that describes the estimated monthly savings amount possible by
    /// adopting Compute Optimizer recommendations for a given
    /// resource. This is based on the On-Demand instance pricing..
    estimated_monthly_savings: ?EstimatedMonthlySavings,

    /// The estimated monthly savings possible as a percentage of monthly cost by
    /// adopting
    /// Compute Optimizer recommendations for a given resource.
    savings_opportunity_percentage: f64 = 0,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .savings_opportunity_percentage = "savingsOpportunityPercentage",
    };
};
