const InstanceInfo = @import("instance_info.zig").InstanceInfo;

/// Information about a managed node's type.
pub const NodeType = union(enum) {
    /// Information about a specific managed node.
    instance: ?InstanceInfo,

    pub const json_field_names = .{
        .instance = "Instance",
    };
};
