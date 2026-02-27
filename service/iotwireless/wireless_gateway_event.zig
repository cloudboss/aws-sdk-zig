/// The event for a log message, if the log message is tied to a wireless
/// gateway.
pub const WirelessGatewayEvent = enum {
    cups_request,
    certificate,

    pub const json_field_names = .{
        .cups_request = "CUPS_Request",
        .certificate = "Certificate",
    };
};
