const CostFrequency = @import("cost_frequency.zig").CostFrequency;

/// Defines a cost object.
pub const Cost = struct {
    /// The cost amount.
    amount: f64 = 0,

    /// The cost currency, for example `USD`.
    currency: []const u8,

    /// The cost frequency.
    frequency: CostFrequency,

    pub const json_field_names = .{
        .amount = "amount",
        .currency = "currency",
        .frequency = "frequency",
    };
};
