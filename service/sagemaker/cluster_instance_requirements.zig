const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;

/// The instance requirements for a flexible instance group. Use this to specify
/// multiple instance types that the instance group can use. The order of
/// instance types in the list determines the priority for instance
/// provisioning.
pub const ClusterInstanceRequirements = struct {
    /// The list of instance types that the instance group can use. The order of
    /// instance types determines the priority—HyperPod attempts to provision
    /// instances using the first instance type in the list and falls back to
    /// subsequent types if capacity is unavailable.
    instance_types: []const ClusterInstanceType,

    pub const json_field_names = .{
        .instance_types = "InstanceTypes",
    };
};
