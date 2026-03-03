const GatewayType = @import("gateway_type.zig").GatewayType;
const MaintenanceStartTime = @import("maintenance_start_time.zig").MaintenanceStartTime;

/// The details of gateway.
pub const GatewayDetails = struct {
    /// The Amazon Resource Name (ARN) of the
    /// gateway. Use the `ListGateways` operation
    /// to return a list of gateways for your account and
    /// Amazon Web Services Region.
    gateway_arn: ?[]const u8 = null,

    /// The display name of the gateway.
    gateway_display_name: ?[]const u8 = null,

    /// The type of the gateway type.
    gateway_type: ?GatewayType = null,

    /// The hypervisor ID of the gateway.
    hypervisor_id: ?[]const u8 = null,

    /// Details showing the last time Backup gateway communicated
    /// with the cloud, in Unix format and UTC time.
    last_seen_time: ?i64 = null,

    /// Returns your gateway's weekly maintenance start time including the day and
    /// time of the week.
    /// Note that values are in terms of the gateway's time zone. Can be weekly or
    /// monthly.
    maintenance_start_time: ?MaintenanceStartTime = null,

    /// Details showing the next update availability time of the
    /// gateway.
    next_update_availability_time: ?i64 = null,

    /// The DNS name for the virtual private cloud (VPC) endpoint the gateway
    /// uses to connect to the cloud for backup gateway.
    vpc_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayArn",
        .gateway_display_name = "GatewayDisplayName",
        .gateway_type = "GatewayType",
        .hypervisor_id = "HypervisorId",
        .last_seen_time = "LastSeenTime",
        .maintenance_start_time = "MaintenanceStartTime",
        .next_update_availability_time = "NextUpdateAvailabilityTime",
        .vpc_endpoint = "VpcEndpoint",
    };
};
