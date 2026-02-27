/// Contains details for a participant in a transfer. A *transfer* is
/// the arrangement between two management accounts where one account designates
/// the other
/// with specified responsibilities for their organization.
pub const TransferParticipant = struct {
    /// Email address for the management account.
    management_account_email: ?[]const u8,

    /// ID for the management account.
    management_account_id: ?[]const u8,

    pub const json_field_names = .{
        .management_account_email = "ManagementAccountEmail",
        .management_account_id = "ManagementAccountId",
    };
};
