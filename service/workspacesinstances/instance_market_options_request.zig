const MarketTypeEnum = @import("market_type_enum.zig").MarketTypeEnum;
const SpotMarketOptions = @import("spot_market_options.zig").SpotMarketOptions;

/// Configures marketplace-specific instance deployment options.
pub const InstanceMarketOptionsRequest = struct {
    /// Specifies the type of marketplace for instance deployment.
    market_type: ?MarketTypeEnum,

    /// Configuration options for spot instance deployment.
    spot_options: ?SpotMarketOptions,

    pub const json_field_names = .{
        .market_type = "MarketType",
        .spot_options = "SpotOptions",
    };
};
