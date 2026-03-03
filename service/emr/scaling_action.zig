const MarketType = @import("market_type.zig").MarketType;
const SimpleScalingPolicyConfiguration = @import("simple_scaling_policy_configuration.zig").SimpleScalingPolicyConfiguration;

/// The type of adjustment the automatic scaling activity makes when triggered,
/// and the
/// periodicity of the adjustment.
pub const ScalingAction = struct {
    /// Not available for instance groups. Instance groups use the market type
    /// specified for the
    /// group.
    market: ?MarketType = null,

    /// The type of adjustment the automatic scaling activity makes when triggered,
    /// and the
    /// periodicity of the adjustment.
    simple_scaling_policy_configuration: SimpleScalingPolicyConfiguration,

    pub const json_field_names = .{
        .market = "Market",
        .simple_scaling_policy_configuration = "SimpleScalingPolicyConfiguration",
    };
};
