const ResourceType = @import("resource_type.zig").ResourceType;

/// Describes an association with a license configuration.
pub const LicenseConfigurationAssociation = struct {
    /// Scope of AMI associations. The possible value is `cross-account`.
    ami_association_scope: ?[]const u8 = null,

    /// Time when the license configuration was associated with the resource.
    association_time: ?i64 = null,

    /// Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8 = null,

    /// ID of the Amazon Web Services account that owns the resource consuming
    /// licenses.
    resource_owner_id: ?[]const u8 = null,

    /// Type of server resource.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .ami_association_scope = "AmiAssociationScope",
        .association_time = "AssociationTime",
        .resource_arn = "ResourceArn",
        .resource_owner_id = "ResourceOwnerId",
        .resource_type = "ResourceType",
    };
};
