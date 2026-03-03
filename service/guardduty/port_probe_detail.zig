const LocalIpDetails = @import("local_ip_details.zig").LocalIpDetails;
const LocalPortDetails = @import("local_port_details.zig").LocalPortDetails;
const RemoteIpDetails = @import("remote_ip_details.zig").RemoteIpDetails;

/// Contains information about the port probe details.
pub const PortProbeDetail = struct {
    /// The local IP information of the connection.
    local_ip_details: ?LocalIpDetails = null,

    /// The local port information of the connection.
    local_port_details: ?LocalPortDetails = null,

    /// The remote IP information of the connection.
    remote_ip_details: ?RemoteIpDetails = null,

    pub const json_field_names = .{
        .local_ip_details = "LocalIpDetails",
        .local_port_details = "LocalPortDetails",
        .remote_ip_details = "RemoteIpDetails",
    };
};
