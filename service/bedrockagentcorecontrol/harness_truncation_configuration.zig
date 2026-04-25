const HarnessTruncationStrategyConfiguration = @import("harness_truncation_strategy_configuration.zig").HarnessTruncationStrategyConfiguration;
const HarnessTruncationStrategy = @import("harness_truncation_strategy.zig").HarnessTruncationStrategy;

/// Configuration for truncating conversation context when it exceeds model
/// limits.
pub const HarnessTruncationConfiguration = struct {
    /// The strategy-specific configuration.
    config: ?HarnessTruncationStrategyConfiguration = null,

    /// The truncation strategy to use.
    strategy: HarnessTruncationStrategy,

    pub const json_field_names = .{
        .config = "config",
        .strategy = "strategy",
    };
};
