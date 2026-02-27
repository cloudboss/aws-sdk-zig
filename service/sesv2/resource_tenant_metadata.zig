/// A structure that contains information about a tenant associated with a
/// resource.
pub const ResourceTenantMetadata = struct {
    /// The date and time when the resource was associated with the tenant.
    associated_timestamp: ?i64,

    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8,

    /// A unique identifier for the tenant associated with the resource.
    tenant_id: ?[]const u8,

    /// The name of the tenant associated with the resource.
    tenant_name: ?[]const u8,

    pub const json_field_names = .{
        .associated_timestamp = "AssociatedTimestamp",
        .resource_arn = "ResourceArn",
        .tenant_id = "TenantId",
        .tenant_name = "TenantName",
    };
};
