/// Contains information about an application tenant.
pub const Tenant = struct {
    /// The display name of the tenant.
    tenant_display_name: []const u8,

    /// The ID of the application tenant.
    tenant_identifier: []const u8,

    pub const json_field_names = .{
        .tenant_display_name = "tenantDisplayName",
        .tenant_identifier = "tenantIdentifier",
    };
};
