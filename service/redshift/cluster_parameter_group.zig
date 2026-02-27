const Tag = @import("tag.zig").Tag;

/// Describes a parameter group.
pub const ClusterParameterGroup = struct {
    /// The description of the parameter group.
    description: ?[]const u8,

    /// The name of the cluster parameter group family that this cluster parameter
    /// group is
    /// compatible with.
    parameter_group_family: ?[]const u8,

    /// The name of the cluster parameter group.
    parameter_group_name: ?[]const u8,

    /// The list of tags for the cluster parameter group.
    tags: ?[]const Tag,
};
