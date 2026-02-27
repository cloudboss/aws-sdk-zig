/// Represents a list of map of accounts with the number of findings associated
/// with each account.
pub const AccountStatistics = struct {
    /// The ID of the Amazon Web Services account.
    account_id: ?[]const u8,

    /// The timestamp at which the finding for this account was last generated.
    last_generated_at: ?i64,

    /// The total number of findings associated with an account.
    total_findings: ?i32,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .last_generated_at = "LastGeneratedAt",
        .total_findings = "TotalFindings",
    };
};
