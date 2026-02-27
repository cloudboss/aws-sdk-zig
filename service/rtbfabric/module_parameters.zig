const NoBidModuleParameters = @import("no_bid_module_parameters.zig").NoBidModuleParameters;
const OpenRtbAttributeModuleParameters = @import("open_rtb_attribute_module_parameters.zig").OpenRtbAttributeModuleParameters;
const RateLimiterModuleParameters = @import("rate_limiter_module_parameters.zig").RateLimiterModuleParameters;

/// Describes the parameters of a module.
pub const ModuleParameters = union(enum) {
    /// Describes the parameters of a no bid module.
    no_bid: ?NoBidModuleParameters,
    /// Describes the parameters of an open RTB attribute module.
    open_rtb_attribute: ?OpenRtbAttributeModuleParameters,
    /// Describes the parameters of a rate limit.
    rate_limiter: ?RateLimiterModuleParameters,

    pub const json_field_names = .{
        .no_bid = "noBid",
        .open_rtb_attribute = "openRtbAttribute",
        .rate_limiter = "rateLimiter",
    };
};
