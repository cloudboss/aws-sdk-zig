const AccessBudgetDetails = @import("access_budget_details.zig").AccessBudgetDetails;

/// An access budget that defines consumption limits for a specific resource
/// within defined time periods.
pub const AccessBudget = struct {
    /// The total remaining budget across all active budget periods for this
    /// resource.
    aggregate_remaining_budget: i32,

    /// A list of budget details for this resource. Contains active budget periods
    /// that apply to the resource.
    details: []const AccessBudgetDetails,

    /// The Amazon Resource Name (ARN) of the resource that this access budget
    /// applies to.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .aggregate_remaining_budget = "aggregateRemainingBudget",
        .details = "details",
        .resource_arn = "resourceArn",
    };
};
