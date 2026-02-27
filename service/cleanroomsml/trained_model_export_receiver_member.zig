/// Provides information about the member who will receive trained model
/// exports.
pub const TrainedModelExportReceiverMember = struct {
    /// The account ID of the member who will receive trained model exports.
    account_id: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};
