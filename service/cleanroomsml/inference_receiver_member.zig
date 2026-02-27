/// Defines who will receive inference results.
pub const InferenceReceiverMember = struct {
    /// The account ID of the member that can receive inference results.
    account_id: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};
