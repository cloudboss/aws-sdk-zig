/// Details identifying the users with permissions to use the action type.
pub const ActionTypePermissions = struct {
    /// A list of Amazon Web Services account IDs with access to use the action type
    /// in their
    /// pipelines.
    allowed_accounts: []const []const u8,

    pub const json_field_names = .{
        .allowed_accounts = "allowedAccounts",
    };
};
