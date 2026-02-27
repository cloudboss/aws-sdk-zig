const CostEstimate = @import("cost_estimate.zig").CostEstimate;
const ResourceType = @import("resource_type.zig").ResourceType;

/// Describes the estimated cost or usage that a budget tracks.
pub const ResourceBudgetEstimate = struct {
    /// The cost estimate for the specified budget.
    cost_estimates: ?[]const CostEstimate,

    /// The estimate end time.
    end_time: ?i64,

    /// The resource name.
    resource_name: ?[]const u8,

    /// The type of resource the budget will track.
    resource_type: ?ResourceType,

    /// The estimate start time.
    start_time: ?i64,

    pub const json_field_names = .{
        .cost_estimates = "costEstimates",
        .end_time = "endTime",
        .resource_name = "resourceName",
        .resource_type = "resourceType",
        .start_time = "startTime",
    };
};
