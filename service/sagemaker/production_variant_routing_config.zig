const PrefixAwareRoutingConfig = @import("prefix_aware_routing_config.zig").PrefixAwareRoutingConfig;
const RoutingStrategy = @import("routing_strategy.zig").RoutingStrategy;

/// Settings that control how the endpoint routes incoming traffic to the
/// instances that the endpoint hosts.
pub const ProductionVariantRoutingConfig = struct {
    /// The configuration for prefix-aware routing. Specify this parameter only when
    /// you set `RoutingStrategy` to `PREFIX_AWARE`.
    prefix_aware_routing_config: ?PrefixAwareRoutingConfig = null,

    /// Sets how the endpoint routes incoming traffic:
    ///
    /// * `LEAST_OUTSTANDING_REQUESTS`: The endpoint routes requests to the specific
    ///   instances that have more capacity to process them.
    /// * `RANDOM`: The endpoint routes each request to a randomly chosen instance.
    /// * `PREFIX_AWARE`: The endpoint routes requests that share the same prompt
    ///   prefix to the same instance. When the number of in-flight requests on the
    ///   selected instance reaches the configured threshold, the endpoint routes
    ///   the request to an instance with more available capacity.
    routing_strategy: RoutingStrategy,

    pub const json_field_names = .{
        .prefix_aware_routing_config = "PrefixAwareRoutingConfig",
        .routing_strategy = "RoutingStrategy",
    };
};
