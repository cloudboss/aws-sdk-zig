const GatewayCapabilitySummary = @import("gateway_capability_summary.zig").GatewayCapabilitySummary;
const GatewayPlatform = @import("gateway_platform.zig").GatewayPlatform;

/// Contains a summary of a gateway.
pub const GatewaySummary = struct {
    /// The date the gateway was created, in Unix epoch time.
    creation_date: i64,

    /// A list of gateway capability summaries that each contain a namespace and
    /// status. Each
    /// gateway capability defines data sources for the gateway. To retrieve a
    /// capability
    /// configuration's definition, use
    /// [DescribeGatewayCapabilityConfiguration](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_DescribeGatewayCapabilityConfiguration.html).
    gateway_capability_summaries: ?[]const GatewayCapabilitySummary,

    /// The ID of the gateway device.
    gateway_id: []const u8,

    /// The name of the gateway.
    gateway_name: []const u8,

    gateway_platform: ?GatewayPlatform,

    /// The version of the gateway. A value of `3` indicates an MQTT-enabled, V3
    /// gateway, while `2` indicates a Classic streams, V2 gateway.
    gateway_version: ?[]const u8,

    /// The date the gateway was last updated, in Unix epoch time.
    last_update_date: i64,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .gateway_capability_summaries = "gatewayCapabilitySummaries",
        .gateway_id = "gatewayId",
        .gateway_name = "gatewayName",
        .gateway_platform = "gatewayPlatform",
        .gateway_version = "gatewayVersion",
        .last_update_date = "lastUpdateDate",
    };
};
