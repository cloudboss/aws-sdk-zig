const ResourceType = @import("resource_type.zig").ResourceType;

/// Details about the usage of a resource associated with a license
/// configuration.
pub const LicenseConfigurationUsage = struct {
    /// Time when the license configuration was initially associated with the
    /// resource.
    association_time: ?i64,

    /// Number of licenses consumed by the resource.
    consumed_licenses: ?i64,

    /// Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8,

    /// ID of the account that owns the resource.
    resource_owner_id: ?[]const u8,

    /// Status of the resource.
    resource_status: ?[]const u8,

    /// Type of resource.
    resource_type: ?ResourceType,

    pub const json_field_names = .{
        .association_time = "AssociationTime",
        .consumed_licenses = "ConsumedLicenses",
        .resource_arn = "ResourceArn",
        .resource_owner_id = "ResourceOwnerId",
        .resource_status = "ResourceStatus",
        .resource_type = "ResourceType",
    };
};
