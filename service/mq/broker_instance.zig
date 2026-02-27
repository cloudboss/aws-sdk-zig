/// Returns information about all brokers.
pub const BrokerInstance = struct {
    /// The brokers web console URL.
    console_url: ?[]const u8,

    /// The broker's wire-level protocol endpoints.
    endpoints: ?[]const []const u8,

    /// The IP address of the Elastic Network Interface (ENI) attached to the
    /// broker. Does not apply to RabbitMQ brokers.
    ip_address: ?[]const u8,

    pub const json_field_names = .{
        .console_url = "ConsoleURL",
        .endpoints = "Endpoints",
        .ip_address = "IpAddress",
    };
};
