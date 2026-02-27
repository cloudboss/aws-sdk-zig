/// The protected job direct analysis configuration details.
pub const ProtectedJobDirectAnalysisConfigurationDetails = struct {
    /// The receiver account IDs.
    receiver_account_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .receiver_account_ids = "receiverAccountIds",
    };
};
