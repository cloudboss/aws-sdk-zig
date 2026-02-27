/// The protected job member output configuration input.
pub const ProtectedJobMemberOutputConfigurationInput = struct {
    /// The account ID.
    account_id: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};
