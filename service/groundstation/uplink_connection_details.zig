const RangedConnectionDetails = @import("ranged_connection_details.zig").RangedConnectionDetails;
const ConnectionDetails = @import("connection_details.zig").ConnectionDetails;

/// Connection details for customer to Agent and Agent to Ground Station
pub const UplinkConnectionDetails = struct {
    agent_ip_and_port_address: RangedConnectionDetails,

    ingress_address_and_port: ConnectionDetails,

    pub const json_field_names = .{
        .agent_ip_and_port_address = "agentIpAndPortAddress",
        .ingress_address_and_port = "ingressAddressAndPort",
    };
};
