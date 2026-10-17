/// A structure that identifies a row-level security policy as a resource, used
/// when granting permissions on the policy.
pub const RLSPolicyResource = struct {
    /// The identifier for the Data Catalog that contains the policy. By default,
    /// the account ID.
    catalog_id: ?[]const u8 = null,

    /// The name of the row-level security policy.
    name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .name = "Name",
    };
};
