const MarketType = @import("market_type.zig").MarketType;
const SpotMarketOptions = @import("spot_market_options.zig").SpotMarketOptions;

/// Describes the market (purchasing) option for the instances.
pub const InstanceMarketOptionsRequest = struct {
    /// The market type.
    market_type: ?MarketType = null,

    /// The options for Spot Instances.
    spot_options: ?SpotMarketOptions = null,
};
