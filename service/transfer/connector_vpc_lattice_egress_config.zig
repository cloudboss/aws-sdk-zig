/// VPC_LATTICE egress configuration that specifies the Resource Configuration
/// ARN and port for connecting to SFTP servers through customer VPCs. Requires
/// a valid Resource Configuration with appropriate network access.
pub const ConnectorVpcLatticeEgressConfig = struct {
    /// Port number for connecting to the SFTP server through VPC_LATTICE. Defaults
    /// to 22 if not specified. Must match the port on which the target SFTP server
    /// is listening.
    port_number: ?i32,

    /// ARN of the VPC_LATTICE Resource Configuration that defines the target SFTP
    /// server location. Must point to a valid Resource Configuration in the
    /// customer's VPC with appropriate network connectivity to the SFTP server.
    resource_configuration_arn: []const u8,

    pub const json_field_names = .{
        .port_number = "PortNumber",
        .resource_configuration_arn = "ResourceConfigurationArn",
    };
};
