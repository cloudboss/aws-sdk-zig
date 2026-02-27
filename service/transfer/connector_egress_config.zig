const ConnectorVpcLatticeEgressConfig = @import("connector_vpc_lattice_egress_config.zig").ConnectorVpcLatticeEgressConfig;

/// Configuration structure that defines how traffic is routed from the
/// connector to the SFTP server. Contains VPC Lattice settings when using
/// VPC_LATTICE egress type for private connectivity through customer VPCs.
pub const ConnectorEgressConfig = union(enum) {
    /// VPC_LATTICE configuration for routing connector traffic through customer
    /// VPCs. Enables private connectivity to SFTP servers without requiring public
    /// internet access or complex network configurations.
    vpc_lattice: ?ConnectorVpcLatticeEgressConfig,

    pub const json_field_names = .{
        .vpc_lattice = "VpcLattice",
    };
};
