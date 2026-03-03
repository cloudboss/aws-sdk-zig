const GatewayType = @import("gateway_type.zig").GatewayType;

/// A gateway is an Backup Gateway appliance that runs on the customer's network
/// to provide seamless connectivity to backup storage in the Amazon Web
/// Services Cloud.
pub const Gateway = struct {
    /// The Amazon Resource Name (ARN) of the gateway. Use the `ListGateways`
    /// operation
    /// to return a list of gateways for your account and Amazon Web Services
    /// Region.
    gateway_arn: ?[]const u8 = null,

    /// The display name of the gateway.
    gateway_display_name: ?[]const u8 = null,

    /// The type of the gateway.
    gateway_type: ?GatewayType = null,

    /// The hypervisor ID of the gateway.
    hypervisor_id: ?[]const u8 = null,

    /// The last time Backup gateway communicated with the gateway, in Unix format
    /// and
    /// UTC time.
    last_seen_time: ?i64 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayArn",
        .gateway_display_name = "GatewayDisplayName",
        .gateway_type = "GatewayType",
        .hypervisor_id = "HypervisorId",
        .last_seen_time = "LastSeenTime",
    };
};
