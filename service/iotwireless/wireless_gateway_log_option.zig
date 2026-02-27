const WirelessGatewayEventLogOption = @import("wireless_gateway_event_log_option.zig").WirelessGatewayEventLogOption;
const LogLevel = @import("log_level.zig").LogLevel;
const WirelessGatewayType = @import("wireless_gateway_type.zig").WirelessGatewayType;

/// The log options for wireless gateways and can be used to set log levels for
/// a specific
/// type of wireless gateway.
pub const WirelessGatewayLogOption = struct {
    events: ?[]const WirelessGatewayEventLogOption,

    log_level: LogLevel,

    type: WirelessGatewayType,

    pub const json_field_names = .{
        .events = "Events",
        .log_level = "LogLevel",
        .type = "Type",
    };
};
