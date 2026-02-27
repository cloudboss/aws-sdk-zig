const NetworkPath = @import("network_path.zig").NetworkPath;
const PortRange = @import("port_range.zig").PortRange;
const NetworkProtocol = @import("network_protocol.zig").NetworkProtocol;

/// Contains the details of a network reachability finding.
pub const NetworkReachabilityDetails = struct {
    /// An object that contains details about a network path associated with a
    /// finding.
    network_path: NetworkPath,

    /// An object that contains details about the open port range associated with a
    /// finding.
    open_port_range: PortRange,

    /// The protocol associated with a finding.
    protocol: NetworkProtocol,

    pub const json_field_names = .{
        .network_path = "networkPath",
        .open_port_range = "openPortRange",
        .protocol = "protocol",
    };
};
