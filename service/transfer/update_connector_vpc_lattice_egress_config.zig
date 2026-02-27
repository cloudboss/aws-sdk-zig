/// VPC_LATTICE egress configuration updates for modifying how the connector
/// routes traffic through customer VPCs. Changes to these settings may require
/// connector restart to take effect.
pub const UpdateConnectorVpcLatticeEgressConfig = struct {
    /// Updated port number for SFTP connections through VPC_LATTICE. Change this if
    /// the target SFTP server port has been modified or if connecting to a
    /// different server endpoint.
    port_number: ?i32,

    /// Updated ARN of the VPC_LATTICE Resource Configuration. Use this to change
    /// the target SFTP server location or modify the network path through the
    /// customer's VPC infrastructure.
    resource_configuration_arn: ?[]const u8,

    pub const json_field_names = .{
        .port_number = "PortNumber",
        .resource_configuration_arn = "ResourceConfigurationArn",
    };
};
