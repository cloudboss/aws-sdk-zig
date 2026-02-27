/// The Amazon Resource Name (ARN) of the Amazon VPC Lattice resource
/// configuration for the resource endpoint.
pub const ConnectivityResourceConfigurationArn = struct {
    /// The Amazon Resource Name (ARN) of the Amazon VPC Lattice resource
    /// configuration for the resource endpoint.
    resource_configuration_arn: []const u8,

    pub const json_field_names = .{
        .resource_configuration_arn = "ResourceConfigurationArn",
    };
};
