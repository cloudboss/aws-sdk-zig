/// Represents a usage quantity for a workload estimate.
pub const WorkloadEstimateUsageQuantity = struct {
    /// The numeric value of the usage quantity.
    amount: ?f64 = null,

    /// The unit of measurement for the usage quantity.
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .amount = "amount",
        .unit = "unit",
    };
};
