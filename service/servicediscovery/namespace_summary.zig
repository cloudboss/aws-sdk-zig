const NamespaceProperties = @import("namespace_properties.zig").NamespaceProperties;
const NamespaceType = @import("namespace_type.zig").NamespaceType;

/// A complex type that contains information about a namespace.
pub const NamespaceSummary = struct {
    /// The Amazon Resource Name (ARN) that Cloud Map assigns to the namespace when
    /// you create it.
    arn: ?[]const u8 = null,

    /// The date and time that the namespace was created.
    create_date: ?i64 = null,

    /// A description for the namespace.
    description: ?[]const u8 = null,

    /// The ID of the namespace.
    id: ?[]const u8 = null,

    /// The name of the namespace. When you create a namespace, Cloud Map
    /// automatically creates a
    /// Route 53 hosted zone that has the same name as the namespace.
    name: ?[]const u8 = null,

    /// The properties of the namespace.
    properties: ?NamespaceProperties = null,

    /// The ID of the Amazon Web Services account that created the namespace. If
    /// this isn't your account ID, it's
    /// the ID of the account that shared the namespace with your account. For more
    /// information about
    /// shared namespaces, see [Cross-account Cloud Map namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the
    /// *Cloud Map Developer Guide*.
    resource_owner: ?[]const u8 = null,

    /// The number of services that were created using the namespace.
    service_count: ?i32 = null,

    /// The type of the namespace, either public or private.
    @"type": ?NamespaceType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .create_date = "CreateDate",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .properties = "Properties",
        .resource_owner = "ResourceOwner",
        .service_count = "ServiceCount",
        .@"type" = "Type",
    };
};
