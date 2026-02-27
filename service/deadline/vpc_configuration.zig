/// The configuration options for a service managed fleet's VPC.
pub const VpcConfiguration = struct {
    /// The ARNs of the VPC Lattice resource configurations attached to the fleet.
    resource_configuration_arns: ?[]const []const u8,

    pub const json_field_names = .{
        .resource_configuration_arns = "resourceConfigurationArns",
    };
};
