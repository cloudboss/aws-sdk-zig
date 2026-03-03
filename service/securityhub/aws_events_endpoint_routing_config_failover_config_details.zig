const AwsEventsEndpointRoutingConfigFailoverConfigPrimaryDetails = @import("aws_events_endpoint_routing_config_failover_config_primary_details.zig").AwsEventsEndpointRoutingConfigFailoverConfigPrimaryDetails;
const AwsEventsEndpointRoutingConfigFailoverConfigSecondaryDetails = @import("aws_events_endpoint_routing_config_failover_config_secondary_details.zig").AwsEventsEndpointRoutingConfigFailoverConfigSecondaryDetails;

/// The failover configuration for an endpoint. This includes what triggers
/// failover and what happens when it's triggered.
pub const AwsEventsEndpointRoutingConfigFailoverConfigDetails = struct {
    /// The main Region of the endpoint.
    primary: ?AwsEventsEndpointRoutingConfigFailoverConfigPrimaryDetails = null,

    /// The Region that events are routed to when failover is triggered or event
    /// replication is enabled.
    secondary: ?AwsEventsEndpointRoutingConfigFailoverConfigSecondaryDetails = null,

    pub const json_field_names = .{
        .primary = "Primary",
        .secondary = "Secondary",
    };
};
