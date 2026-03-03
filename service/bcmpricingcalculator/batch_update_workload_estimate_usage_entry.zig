/// Represents an entry in a batch operation to update workload estimate usage.
pub const BatchUpdateWorkloadEstimateUsageEntry = struct {
    /// The updated estimated usage amount.
    amount: ?f64 = null,

    /// The updated group identifier for the usage estimate.
    group: ?[]const u8 = null,

    /// The unique identifier of the usage estimate to update.
    id: []const u8,

    pub const json_field_names = .{
        .amount = "amount",
        .group = "group",
        .id = "id",
    };
};
