const ManagedVpcResource = @import("managed_vpc_resource.zig").ManagedVpcResource;
const SelfManagedLatticeResource = @import("self_managed_lattice_resource.zig").SelfManagedLatticeResource;

/// A private network endpoint used to reach a resource over a private path.
/// Exactly one member is set.
pub const PrivateEndpoint = union(enum) {
    /// A private endpoint backed by a service-managed VPC resource.
    managed_vpc_resource: ?ManagedVpcResource,
    /// A private endpoint backed by a self-managed VPC Lattice resource
    /// configuration.
    self_managed_lattice_resource: ?SelfManagedLatticeResource,

    pub const json_field_names = .{
        .managed_vpc_resource = "managedVpcResource",
        .self_managed_lattice_resource = "selfManagedLatticeResource",
    };
};
