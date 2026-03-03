const MarketType = @import("market_type.zig").MarketType;
const LaunchTemplateSpotMarketOptions = @import("launch_template_spot_market_options.zig").LaunchTemplateSpotMarketOptions;

/// The market (purchasing) option for the instances.
pub const LaunchTemplateInstanceMarketOptions = struct {
    /// The market type.
    market_type: ?MarketType = null,

    /// The options for Spot Instances.
    spot_options: ?LaunchTemplateSpotMarketOptions = null,
};
