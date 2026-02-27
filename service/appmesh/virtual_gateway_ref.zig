/// An object that represents a virtual gateway returned by a list operation.
pub const VirtualGatewayRef = struct {
    /// The full Amazon Resource Name (ARN) for the resource.
    arn: []const u8,

    /// The Unix epoch timestamp in seconds for when the resource was created.
    created_at: i64,

    /// The Unix epoch timestamp in seconds for when the resource was last updated.
    last_updated_at: i64,

    /// The name of the service mesh that the resource resides in.
    mesh_name: []const u8,

    /// The Amazon Web Services IAM account ID of the service mesh owner. If the
    /// account ID is not your own, then it's
    /// the ID of the account that shared the mesh with your account. For more
    /// information about mesh sharing, see [Working with shared
    /// meshes](https://docs.aws.amazon.com/app-mesh/latest/userguide/sharing.html).
    mesh_owner: []const u8,

    /// The Amazon Web Services IAM account ID of the resource owner. If the account
    /// ID is not your own, then it's
    /// the ID of the mesh owner or of another account that the mesh is shared with.
    /// For more information about mesh sharing, see [Working with shared
    /// meshes](https://docs.aws.amazon.com/app-mesh/latest/userguide/sharing.html).
    resource_owner: []const u8,

    /// The version of the resource. Resources are created at version 1, and this
    /// version is incremented each time that they're updated.
    version: i64,

    /// The name of the resource.
    virtual_gateway_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .last_updated_at = "lastUpdatedAt",
        .mesh_name = "meshName",
        .mesh_owner = "meshOwner",
        .resource_owner = "resourceOwner",
        .version = "version",
        .virtual_gateway_name = "virtualGatewayName",
    };
};
