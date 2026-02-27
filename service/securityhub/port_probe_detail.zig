const ActionLocalIpDetails = @import("action_local_ip_details.zig").ActionLocalIpDetails;
const ActionLocalPortDetails = @import("action_local_port_details.zig").ActionLocalPortDetails;
const ActionRemoteIpDetails = @import("action_remote_ip_details.zig").ActionRemoteIpDetails;

/// A port scan that was part of the port probe. For each scan, PortProbeDetails
/// provides
/// information about the local IP address and port that were scanned, and the
/// remote IP
/// address that the scan originated from.
pub const PortProbeDetail = struct {
    /// Provides information about the IP address where the scanned port is located.
    local_ip_details: ?ActionLocalIpDetails,

    /// Provides information about the port that was scanned.
    local_port_details: ?ActionLocalPortDetails,

    /// Provides information about the remote IP address that performed the scan.
    remote_ip_details: ?ActionRemoteIpDetails,

    pub const json_field_names = .{
        .local_ip_details = "LocalIpDetails",
        .local_port_details = "LocalPortDetails",
        .remote_ip_details = "RemoteIpDetails",
    };
};
