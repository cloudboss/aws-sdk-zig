const DescribedConnectorVpcLatticeEgressConfig = @import("described_connector_vpc_lattice_egress_config.zig").DescribedConnectorVpcLatticeEgressConfig;

/// Response structure containing the current egress configuration details for
/// the connector. Shows how traffic is currently routed from the connector to
/// the SFTP server.
pub const DescribedConnectorEgressConfig = union(enum) {
    /// VPC_LATTICE configuration details in the response, showing the current
    /// Resource Configuration ARN and port settings for VPC-based connectivity.
    vpc_lattice: ?DescribedConnectorVpcLatticeEgressConfig,

    pub const json_field_names = .{
        .vpc_lattice = "VpcLattice",
    };
};
