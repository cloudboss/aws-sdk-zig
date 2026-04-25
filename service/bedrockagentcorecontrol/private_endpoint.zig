const ManagedLatticeResource = @import("managed_lattice_resource.zig").ManagedLatticeResource;
const SelfManagedLatticeResource = @import("self_managed_lattice_resource.zig").SelfManagedLatticeResource;

/// The private endpoint configuration for a gateway target. Defines how the
/// gateway connects to private resources in your VPC.
pub const PrivateEndpoint = union(enum) {
    /// Configuration for connecting to a private resource using a managed VPC
    /// Lattice resource. The gateway creates and manages the VPC Lattice resources
    /// on your behalf.
    managed_lattice_resource: ?ManagedLatticeResource,
    /// Configuration for connecting to a private resource using a self-managed VPC
    /// Lattice resource configuration.
    self_managed_lattice_resource: ?SelfManagedLatticeResource,

    pub const json_field_names = .{
        .managed_lattice_resource = "managedLatticeResource",
        .self_managed_lattice_resource = "selfManagedLatticeResource",
    };
};
