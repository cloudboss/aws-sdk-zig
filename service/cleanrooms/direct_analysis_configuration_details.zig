/// The direct analysis configuration details.
pub const DirectAnalysisConfigurationDetails = struct {
    /// The account IDs for the member who received the results of a protected
    /// query.
    receiver_account_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .receiver_account_ids = "receiverAccountIds",
    };
};
