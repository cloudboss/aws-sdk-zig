/// A target ID is an internally-generated identifier for a target. A target
/// allows you to identify all the resources in a Network Flow Monitor scope.
/// Currently, a target is always an Amazon Web Services account.
pub const TargetId = union(enum) {
    /// The identifier for the account for a target.
    account_id: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};
