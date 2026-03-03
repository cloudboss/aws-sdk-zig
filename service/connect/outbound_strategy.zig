const OutboundStrategyConfig = @import("outbound_strategy_config.zig").OutboundStrategyConfig;
const OutboundStrategyType = @import("outbound_strategy_type.zig").OutboundStrategyType;

/// Information about the outbound strategy.
pub const OutboundStrategy = struct {
    /// Config of the outbound strategy.
    config: ?OutboundStrategyConfig = null,

    /// Type of the outbound strategy.
    @"type": OutboundStrategyType,

    pub const json_field_names = .{
        .config = "Config",
        .@"type" = "Type",
    };
};
