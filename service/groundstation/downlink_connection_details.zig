const RangedConnectionDetails = @import("ranged_connection_details.zig").RangedConnectionDetails;
const ConnectionDetails = @import("connection_details.zig").ConnectionDetails;

/// Connection details for Ground Station to Agent and Agent to customer
pub const DownlinkConnectionDetails = struct {
    agent_ip_and_port_address: RangedConnectionDetails,

    egress_address_and_port: ConnectionDetails,

    pub const json_field_names = .{
        .agent_ip_and_port_address = "agentIpAndPortAddress",
        .egress_address_and_port = "egressAddressAndPort",
    };
};
