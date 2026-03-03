const MarketType = @import("market_type.zig").MarketType;
const LaunchTemplateSpotMarketOptionsRequest = @import("launch_template_spot_market_options_request.zig").LaunchTemplateSpotMarketOptionsRequest;

/// The market (purchasing) option for the instances.
pub const LaunchTemplateInstanceMarketOptionsRequest = struct {
    /// The market type.
    market_type: ?MarketType = null,

    /// The options for Spot Instances.
    spot_options: ?LaunchTemplateSpotMarketOptionsRequest = null,
};
