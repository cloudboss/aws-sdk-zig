const NamespaceProperties = @import("namespace_properties.zig").NamespaceProperties;
const NamespaceType = @import("namespace_type.zig").NamespaceType;

/// A complex type that contains information about a specified namespace.
pub const Namespace = struct {
    /// The Amazon Resource Name (ARN) that Cloud Map assigns to the namespace when
    /// you create it.
    arn: ?[]const u8 = null,

    /// The date that the namespace was created, in Unix date/time format and
    /// Coordinated Universal
    /// Time (UTC). The value of `CreateDate` is accurate to milliseconds. For
    /// example, the
    /// value `1516925490.087` represents Friday, January 26, 2018 12:11:30.087 AM.
    create_date: ?i64 = null,

    /// A unique string that identifies the request and that allows failed requests
    /// to be retried
    /// without the risk of running an operation twice.
    creator_request_id: ?[]const u8 = null,

    /// The description that you specify for the namespace when you create it.
    description: ?[]const u8 = null,

    /// The ID of a namespace.
    id: ?[]const u8 = null,

    /// The name of the namespace, such as `example.com`.
    name: ?[]const u8 = null,

    /// A complex type that contains information that's specific to the type of the
    /// namespace.
    properties: ?NamespaceProperties = null,

    /// The ID of the Amazon Web Services account that created the namespace. If
    /// this isn't your account ID, it's
    /// the ID of the account that shared the namespace with your account. For more
    /// information about
    /// shared namespaces, see [Cross-account Cloud Map namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the
    /// *Cloud Map Developer Guide*.
    resource_owner: ?[]const u8 = null,

    /// The number of services that are associated with the namespace.
    service_count: ?i32 = null,

    /// The type of the namespace. The methods for discovering instances depends on
    /// the value that
    /// you specify:
    ///
    /// **HTTP**
    ///
    /// Instances can be discovered only programmatically, using the Cloud Map
    /// `DiscoverInstances` API.
    ///
    /// **DNS_PUBLIC**
    ///
    /// Instances can be discovered using public DNS queries and using the
    /// `DiscoverInstances` API.
    ///
    /// **DNS_PRIVATE**
    ///
    /// Instances can be discovered using DNS queries in VPCs and using the
    /// `DiscoverInstances` API.
    @"type": ?NamespaceType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .create_date = "CreateDate",
        .creator_request_id = "CreatorRequestId",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .properties = "Properties",
        .resource_owner = "ResourceOwner",
        .service_count = "ServiceCount",
        .@"type" = "Type",
    };
};
