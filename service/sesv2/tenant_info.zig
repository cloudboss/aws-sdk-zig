/// A structure that contains basic information about a tenant.
pub const TenantInfo = struct {
    /// The date and time when the tenant was created.
    created_timestamp: ?i64,

    /// The Amazon Resource Name (ARN) of the tenant.
    tenant_arn: ?[]const u8,

    /// A unique identifier for the tenant.
    tenant_id: ?[]const u8,

    /// The name of the tenant.
    tenant_name: ?[]const u8,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .tenant_arn = "TenantArn",
        .tenant_id = "TenantId",
        .tenant_name = "TenantName",
    };
};
