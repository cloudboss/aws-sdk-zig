/// Configuration for a self-managed VPC Lattice resource. You create and manage
/// the VPC Lattice resource gateway and resource configuration, then provide
/// the resource configuration identifier.
pub const SelfManagedLatticeResource = union(enum) {
    /// The ARN or ID of the VPC Lattice resource configuration.
    resource_configuration_identifier: ?[]const u8,

    pub const json_field_names = .{
        .resource_configuration_identifier = "resourceConfigurationIdentifier",
    };
};
