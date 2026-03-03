/// Defines the scope for organization-level rules when previewing matching
/// actions.
pub const OrganizationScope = struct {
    /// List of Amazon Web Services account IDs to include in the organization
    /// scope.
    account_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
    };
};
