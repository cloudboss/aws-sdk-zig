const EnrichmentStrategyMethod = @import("enrichment_strategy_method.zig").EnrichmentStrategyMethod;

/// The strategy used for performing context enrichment.
pub const EnrichmentStrategyConfiguration = struct {
    /// The method used for the context enrichment strategy.
    method: EnrichmentStrategyMethod,

    pub const json_field_names = .{
        .method = "method",
    };
};
