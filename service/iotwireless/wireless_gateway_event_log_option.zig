const WirelessGatewayEvent = @import("wireless_gateway_event.zig").WirelessGatewayEvent;
const LogLevel = @import("log_level.zig").LogLevel;

/// The log options for a wireless gateway event and can be used to set log
/// levels for a
/// specific wireless gateway event.
///
/// For a LoRaWAN gateway, possible events for a log message are `CUPS_Request`
/// and `Certificate`.
pub const WirelessGatewayEventLogOption = struct {
    event: WirelessGatewayEvent,

    log_level: LogLevel,

    pub const json_field_names = .{
        .event = "Event",
        .log_level = "LogLevel",
    };
};
