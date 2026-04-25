const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;

/// The instance requirement details for a flexible instance group, including
/// the current and desired instance types.
pub const ClusterInstanceRequirementDetails = struct {
    /// The instance types currently in use by the instance group.
    current_instance_types: ?[]const ClusterInstanceType = null,

    /// The desired instance types for the instance group, as specified in the most
    /// recent update request.
    desired_instance_types: ?[]const ClusterInstanceType = null,

    pub const json_field_names = .{
        .current_instance_types = "CurrentInstanceTypes",
        .desired_instance_types = "DesiredInstanceTypes",
    };
};
