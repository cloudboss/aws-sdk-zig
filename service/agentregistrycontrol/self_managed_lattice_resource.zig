/// A self-managed private endpoint backed by a VPC Lattice resource
/// configuration. Exactly one member is set.
pub const SelfManagedLatticeResource = union(enum) {
    /// The identifier of the VPC Lattice resource configuration, specified as a
    /// resource configuration ID or ARN.
    resource_configuration_identifier: ?[]const u8,

    pub const json_field_names = .{
        .resource_configuration_identifier = "resourceConfigurationIdentifier",
    };
};
