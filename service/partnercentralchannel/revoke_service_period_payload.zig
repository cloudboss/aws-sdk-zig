/// Payload for revoke service period handshake requests.
pub const RevokeServicePeriodPayload = struct {
    /// A note explaining the reason for revoking the service period.
    note: ?[]const u8,

    /// The identifier of the program management account.
    program_management_account_identifier: []const u8,

    pub const json_field_names = .{
        .note = "note",
        .program_management_account_identifier = "programManagementAccountIdentifier",
    };
};
