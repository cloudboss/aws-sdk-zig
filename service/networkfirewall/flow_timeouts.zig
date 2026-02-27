/// Describes the amount of time that can pass without any traffic sent through
/// the firewall before the firewall determines that the connection is idle and
/// Network Firewall removes the flow entry from its flow table.
/// Existing connections and flows are not impacted when you update this value.
/// Only new connections after you update this value are impacted.
pub const FlowTimeouts = struct {
    /// The number of seconds that can pass without any TCP traffic sent through the
    /// firewall before the firewall determines that the connection is idle.
    /// After the idle timeout passes, data packets are dropped, however, the next
    /// TCP SYN packet is considered a new flow and is processed by the firewall.
    /// Clients or targets can use TCP keepalive packets to reset the idle timeout.
    ///
    /// You can define the `TcpIdleTimeoutSeconds` value to be between 60 and 6000
    /// seconds. If no value is provided, it defaults to 350 seconds.
    tcp_idle_timeout_seconds: ?i32,

    pub const json_field_names = .{
        .tcp_idle_timeout_seconds = "TcpIdleTimeoutSeconds",
    };
};
