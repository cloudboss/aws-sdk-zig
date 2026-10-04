const aws = @import("aws");

const RateConfig = @import("rate_config.zig").RateConfig;

/// A single rule entry within a rate limit that maps dimension values to rate
/// configurations. Each entry defines the rate limits for a specific
/// combination of dimension values.
pub const LimitEntry = struct {
    /// The connection rate limit configuration. Specifies the maximum number of
    /// concurrent connections allowed.
    connections: ?[]const RateConfig = null,

    /// A map of dimension names to dimension values for this rule entry. Keys must
    /// match the parent rate limit's dimension keys. Values may use `*` as a
    /// wildcard, but only in trailing positions based on the dimension keys
    /// ordering.
    dimensions: []const aws.map.StringMapEntry,

    /// The request rate limit configuration. Specifies the maximum number of
    /// requests allowed per time period.
    requests: ?[]const RateConfig = null,

    /// The token rate limit configuration. Specifies the maximum number of tokens
    /// allowed per time period.
    tokens: ?[]const RateConfig = null,

    pub const json_field_names = .{
        .connections = "connections",
        .dimensions = "dimensions",
        .requests = "requests",
        .tokens = "tokens",
    };
};
