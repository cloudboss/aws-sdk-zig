/// A response element in the `ModifyTenantDatabase` operation that describes
/// changes that will be applied. Specific changes are identified by
/// subelements.
pub const TenantDatabasePendingModifiedValues = struct {
    /// The master password for the tenant database.
    master_user_password: ?[]const u8,

    /// The name of the tenant database.
    tenant_db_name: ?[]const u8,
};
