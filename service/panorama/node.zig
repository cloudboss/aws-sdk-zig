const NodeCategory = @import("node_category.zig").NodeCategory;

/// An application node that represents a camera stream, a model, code, or
/// output.
pub const Node = struct {
    /// The node's category.
    category: NodeCategory,

    /// When the node was created.
    created_time: i64,

    /// The node's description.
    description: ?[]const u8 = null,

    /// The node's name.
    name: []const u8,

    /// The node's ID.
    node_id: []const u8,

    /// The account ID of the node's owner.
    owner_account: ?[]const u8 = null,

    /// The node's ARN.
    package_arn: ?[]const u8 = null,

    /// The node's package ID.
    package_id: []const u8,

    /// The node's package name.
    package_name: []const u8,

    /// The node's package version.
    package_version: []const u8,

    /// The node's patch version.
    patch_version: []const u8,

    pub const json_field_names = .{
        .category = "Category",
        .created_time = "CreatedTime",
        .description = "Description",
        .name = "Name",
        .node_id = "NodeId",
        .owner_account = "OwnerAccount",
        .package_arn = "PackageArn",
        .package_id = "PackageId",
        .package_name = "PackageName",
        .package_version = "PackageVersion",
        .patch_version = "PatchVersion",
    };
};
