/// Network details about the host where the agent/collector resides.
pub const AgentNetworkInfo = struct {
    /// The IP address for the host where the agent/collector resides.
    ip_address: ?[]const u8,

    /// The MAC address for the host where the agent/collector resides.
    mac_address: ?[]const u8,

    pub const json_field_names = .{
        .ip_address = "ipAddress",
        .mac_address = "macAddress",
    };
};
