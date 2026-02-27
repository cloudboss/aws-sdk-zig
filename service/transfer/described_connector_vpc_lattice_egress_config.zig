/// VPC_LATTICE egress configuration details in the response, containing the
/// Resource Configuration ARN and port number currently configured for the
/// connector.
pub const DescribedConnectorVpcLatticeEgressConfig = struct {
    /// Port number currently configured for SFTP connections through VPC_LATTICE.
    /// Shows the port on which the connector attempts to connect to the target SFTP
    /// server.
    port_number: ?i32,

    /// ARN of the VPC_LATTICE Resource Configuration currently used by the
    /// connector. This Resource Configuration defines the network path to the SFTP
    /// server through the customer's VPC.
    resource_configuration_arn: []const u8,

    pub const json_field_names = .{
        .port_number = "PortNumber",
        .resource_configuration_arn = "ResourceConfigurationArn",
    };
};
