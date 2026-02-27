/// Specific optimization strategies partners can implement to reduce costs.
pub const AwsProductOptimization = struct {
    /// Human-readable explanation of the optimization strategy.
    description: []const u8,

    /// Quantified cost savings achievable by implementing this optimization.
    savings_amount: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .savings_amount = "SavingsAmount",
    };
};
