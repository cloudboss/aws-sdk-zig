const AwsEventsEndpointRoutingConfigFailoverConfigDetails = @import("aws_events_endpoint_routing_config_failover_config_details.zig").AwsEventsEndpointRoutingConfigFailoverConfigDetails;

/// Provides details about the routing configuration of the endpoint.
pub const AwsEventsEndpointRoutingConfigDetails = struct {
    /// The failover configuration for an endpoint. This includes what triggers
    /// failover and what happens when it's triggered.
    failover_config: ?AwsEventsEndpointRoutingConfigFailoverConfigDetails,

    pub const json_field_names = .{
        .failover_config = "FailoverConfig",
    };
};
