const ResourceType = @import("resource_type.zig").ResourceType;

/// Details about the usage of a resource associated with a license
/// configuration.
pub const LicenseConfigurationUsage = struct {
    /// Time when the license configuration was initially associated with the
    /// resource.
    association_time: ?i64 = null,

    /// Number of licenses consumed by the resource.
    consumed_licenses: ?i64 = null,

    /// Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8 = null,

    /// ID of the account that owns the resource.
    resource_owner_id: ?[]const u8 = null,

    /// Status of the resource.
    resource_status: ?[]const u8 = null,

    /// Type of resource.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .association_time = "AssociationTime",
        .consumed_licenses = "ConsumedLicenses",
        .resource_arn = "ResourceArn",
        .resource_owner_id = "ResourceOwnerId",
        .resource_status = "ResourceStatus",
        .resource_type = "ResourceType",
    };
};
