/// The protected job member output configuration output.
pub const ProtectedJobMemberOutputConfigurationOutput = struct {
    /// The account ID.
    account_id: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};
