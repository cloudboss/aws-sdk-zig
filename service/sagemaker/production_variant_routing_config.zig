const RoutingStrategy = @import("routing_strategy.zig").RoutingStrategy;

/// Settings that control how the endpoint routes incoming traffic to the
/// instances that the endpoint hosts.
pub const ProductionVariantRoutingConfig = struct {
    /// Sets how the endpoint routes incoming traffic:
    ///
    /// * `LEAST_OUTSTANDING_REQUESTS`: The endpoint routes requests to the specific
    ///   instances that have more capacity to process them.
    /// * `RANDOM`: The endpoint routes each request to a randomly chosen instance.
    routing_strategy: RoutingStrategy,

    pub const json_field_names = .{
        .routing_strategy = "RoutingStrategy",
    };
};
