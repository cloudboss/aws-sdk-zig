const NodeInstanceStatus = @import("node_instance_status.zig").NodeInstanceStatus;

/// A node instance.
pub const NodeInstance = struct {
    /// The instance's current status.
    current_status: NodeInstanceStatus,

    /// The node's ID.
    node_id: ?[]const u8 = null,

    /// The instance's ID.
    node_instance_id: []const u8,

    /// The instance's name.
    node_name: ?[]const u8 = null,

    /// The instance's package name.
    package_name: ?[]const u8 = null,

    /// The instance's package patch version.
    package_patch_version: ?[]const u8 = null,

    /// The instance's package version.
    package_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_status = "CurrentStatus",
        .node_id = "NodeId",
        .node_instance_id = "NodeInstanceId",
        .node_name = "NodeName",
        .package_name = "PackageName",
        .package_patch_version = "PackagePatchVersion",
        .package_version = "PackageVersion",
    };
};
