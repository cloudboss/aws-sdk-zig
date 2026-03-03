const AwsEventsEndpointEventBusesDetails = @import("aws_events_endpoint_event_buses_details.zig").AwsEventsEndpointEventBusesDetails;
const AwsEventsEndpointReplicationConfigDetails = @import("aws_events_endpoint_replication_config_details.zig").AwsEventsEndpointReplicationConfigDetails;
const AwsEventsEndpointRoutingConfigDetails = @import("aws_events_endpoint_routing_config_details.zig").AwsEventsEndpointRoutingConfigDetails;

/// Provides details about an Amazon EventBridge global endpoint. The endpoint
/// can improve your application’s
/// availability by making it Regional-fault tolerant.
pub const AwsEventsEndpointDetails = struct {
    /// The Amazon Resource Name (ARN) of the endpoint.
    arn: ?[]const u8 = null,

    /// A description of the endpoint.
    description: ?[]const u8 = null,

    /// The URL subdomain of the endpoint. For example, if `EndpointUrl` is
    /// `https://abcde.veo.endpoints.event.amazonaws.com`, then the `EndpointId` is
    /// `abcde.veo`.
    endpoint_id: ?[]const u8 = null,

    /// The URL of the endpoint.
    endpoint_url: ?[]const u8 = null,

    /// The event buses being used by the endpoint.
    event_buses: ?[]const AwsEventsEndpointEventBusesDetails = null,

    /// The name of the endpoint.
    name: ?[]const u8 = null,

    /// Whether event replication was enabled or disabled for this endpoint. The
    /// default state is `ENABLED`, which
    /// means you must supply a `RoleArn`. If you don't have a `RoleArn` or you
    /// don't want event
    /// replication enabled, set the state to `DISABLED`.
    replication_config: ?AwsEventsEndpointReplicationConfigDetails = null,

    /// The ARN of the role used by event replication for the endpoint.
    role_arn: ?[]const u8 = null,

    /// The routing configuration of the endpoint.
    routing_config: ?AwsEventsEndpointRoutingConfigDetails = null,

    /// The current state of the endpoint.
    state: ?[]const u8 = null,

    /// The reason the endpoint is in its current state.
    state_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .endpoint_id = "EndpointId",
        .endpoint_url = "EndpointUrl",
        .event_buses = "EventBuses",
        .name = "Name",
        .replication_config = "ReplicationConfig",
        .role_arn = "RoleArn",
        .routing_config = "RoutingConfig",
        .state = "State",
        .state_reason = "StateReason",
    };
};
