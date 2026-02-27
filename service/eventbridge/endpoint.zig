const EndpointEventBus = @import("endpoint_event_bus.zig").EndpointEventBus;
const ReplicationConfig = @import("replication_config.zig").ReplicationConfig;
const RoutingConfig = @import("routing_config.zig").RoutingConfig;
const EndpointState = @import("endpoint_state.zig").EndpointState;

/// A global endpoint used to improve your application's availability by making
/// it
/// regional-fault tolerant. For more information about global endpoints, see
/// [Making
/// applications Regional-fault tolerant with global endpoints and event
/// replication](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-global-endpoints.html) in
/// the *
/// Amazon EventBridge User Guide*
/// .
pub const Endpoint = struct {
    /// The ARN of the endpoint.
    arn: ?[]const u8,

    /// The time the endpoint was created.
    creation_time: ?i64,

    /// A description for the endpoint.
    description: ?[]const u8,

    /// The URL subdomain of the endpoint. For example, if the URL for Endpoint is
    /// https://abcde.veo.endpoints.event.amazonaws.com, then the EndpointId is
    /// `abcde.veo`.
    endpoint_id: ?[]const u8,

    /// The URL of the endpoint.
    endpoint_url: ?[]const u8,

    /// The event buses being used by the endpoint.
    event_buses: ?[]const EndpointEventBus,

    /// The last time the endpoint was modified.
    last_modified_time: ?i64,

    /// The name of the endpoint.
    name: ?[]const u8,

    /// Whether event replication was enabled or disabled for this endpoint. The
    /// default state is
    /// `ENABLED` which means you must supply a `RoleArn`. If you don't have a
    /// `RoleArn` or you don't want event replication enabled, set the state to
    /// `DISABLED`.
    replication_config: ?ReplicationConfig,

    /// The ARN of the role used by event replication for the endpoint.
    role_arn: ?[]const u8,

    /// The routing configuration of the endpoint.
    routing_config: ?RoutingConfig,

    /// The current state of the endpoint.
    state: ?EndpointState,

    /// The reason the endpoint is in its current state.
    state_reason: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .description = "Description",
        .endpoint_id = "EndpointId",
        .endpoint_url = "EndpointUrl",
        .event_buses = "EventBuses",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .replication_config = "ReplicationConfig",
        .role_arn = "RoleArn",
        .routing_config = "RoutingConfig",
        .state = "State",
        .state_reason = "StateReason",
    };
};
