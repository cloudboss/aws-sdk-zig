const EstimateByTime = @import("estimate_by_time.zig").EstimateByTime;

/// Describes the estimated cost for resources in your Lightsail for Research
/// account.
pub const CostEstimate = struct {
    /// The cost estimate result that's associated with a time period.
    results_by_time: ?[]const EstimateByTime = null,

    /// The types of usage that are included in the estimate, such as costs, usage,
    /// or data
    /// transfer.
    usage_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .results_by_time = "resultsByTime",
        .usage_type = "usageType",
    };
};
