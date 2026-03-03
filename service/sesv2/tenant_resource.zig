const ResourceType = @import("resource_type.zig").ResourceType;

/// A structure that contains information about a resource associated with a
/// tenant.
pub const TenantResource = struct {
    /// The Amazon Resource Name (ARN) of the resource associated with the tenant.
    resource_arn: ?[]const u8 = null,

    /// The type of resource associated with the tenant. Valid values are
    /// `EMAIL_IDENTITY`,
    /// `CONFIGURATION_SET`, or `EMAIL_TEMPLATE`.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_type = "ResourceType",
    };
};
