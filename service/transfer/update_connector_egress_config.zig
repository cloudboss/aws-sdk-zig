const UpdateConnectorVpcLatticeEgressConfig = @import("update_connector_vpc_lattice_egress_config.zig").UpdateConnectorVpcLatticeEgressConfig;

/// Structure for updating the egress configuration of an existing connector.
/// Allows modification of how traffic is routed from the connector to the SFTP
/// server, including VPC_LATTICE settings.
pub const UpdateConnectorEgressConfig = union(enum) {
    /// VPC_LATTICE configuration updates for the connector. Use this to modify the
    /// Resource Configuration ARN or port number for VPC-based connectivity.
    vpc_lattice: ?UpdateConnectorVpcLatticeEgressConfig,

    pub const json_field_names = .{
        .vpc_lattice = "VpcLattice",
    };
};
