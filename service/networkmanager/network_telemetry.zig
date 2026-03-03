const ConnectionHealth = @import("connection_health.zig").ConnectionHealth;

/// Describes the telemetry information for a resource.
pub const NetworkTelemetry = struct {
    /// The Amazon Web Services account ID.
    account_id: ?[]const u8 = null,

    /// The address.
    address: ?[]const u8 = null,

    /// The Amazon Web Services Region.
    aws_region: ?[]const u8 = null,

    /// The ID of a core network.
    core_network_id: ?[]const u8 = null,

    /// The connection health.
    health: ?ConnectionHealth = null,

    /// The ARN of the gateway.
    registered_gateway_arn: ?[]const u8 = null,

    /// The ARN of the resource.
    resource_arn: ?[]const u8 = null,

    /// The ID of the resource.
    resource_id: ?[]const u8 = null,

    /// The resource type.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .address = "Address",
        .aws_region = "AwsRegion",
        .core_network_id = "CoreNetworkId",
        .health = "Health",
        .registered_gateway_arn = "RegisteredGatewayArn",
        .resource_arn = "ResourceArn",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
