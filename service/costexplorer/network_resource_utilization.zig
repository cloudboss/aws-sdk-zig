/// The network field that contains a list of network metrics that are
/// associated with the
/// current instance.
pub const NetworkResourceUtilization = struct {
    /// The network inbound throughput utilization measured in Bytes per second
    /// (Bps).
    network_in_bytes_per_second: ?[]const u8 = null,

    /// The network outbound throughput utilization measured in Bytes per second
    /// (Bps).
    network_out_bytes_per_second: ?[]const u8 = null,

    /// The network inbound packets that are measured in packets per second.
    network_packets_in_per_second: ?[]const u8 = null,

    /// The network outbound packets that are measured in packets per second.
    network_packets_out_per_second: ?[]const u8 = null,

    pub const json_field_names = .{
        .network_in_bytes_per_second = "NetworkInBytesPerSecond",
        .network_out_bytes_per_second = "NetworkOutBytesPerSecond",
        .network_packets_in_per_second = "NetworkPacketsInPerSecond",
        .network_packets_out_per_second = "NetworkPacketsOutPerSecond",
    };
};
