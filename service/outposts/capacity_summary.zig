const QuoteCapacity = @import("quote_capacity.zig").QuoteCapacity;

/// A summary of the capacity changes for a quote option.
pub const CapacitySummary = struct {
    /// The change in capacity between the existing and final state.
    capacity_change: ?[]const QuoteCapacity = null,

    /// The existing capacities on the Outpost before the quote is fulfilled.
    existing_capacities: ?[]const QuoteCapacity = null,

    /// The final capacities on the Outpost after the quote is fulfilled.
    final_capacities: ?[]const QuoteCapacity = null,

    pub const json_field_names = .{
        .capacity_change = "CapacityChange",
        .existing_capacities = "ExistingCapacities",
        .final_capacities = "FinalCapacities",
    };
};
