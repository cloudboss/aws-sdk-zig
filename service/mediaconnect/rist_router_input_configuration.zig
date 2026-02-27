/// The configuration settings for a router input using the RIST (Reliable
/// Internet Stream Transport) protocol, including the port and recovery
/// latency.
pub const RistRouterInputConfiguration = struct {
    /// The port number used for the RIST protocol in the router input
    /// configuration.
    port: i32,

    /// The recovery latency in milliseconds for the RIST protocol in the router
    /// input configuration.
    recovery_latency_milliseconds: i64,

    pub const json_field_names = .{
        .port = "Port",
        .recovery_latency_milliseconds = "RecoveryLatencyMilliseconds",
    };
};
