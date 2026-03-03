const Account = @import("account.zig").Account;

/// Contains information about the user involved in the attack sequence.
pub const User = struct {
    /// Contains information about the Amazon Web Services account.
    account: ?Account = null,

    /// The credentials of the user ID.
    credential_uid: ?[]const u8 = null,

    /// The name of the user.
    name: []const u8,

    /// The type of the user.
    @"type": []const u8,

    /// The unique identifier of the user.
    uid: []const u8,

    pub const json_field_names = .{
        .account = "Account",
        .credential_uid = "CredentialUid",
        .name = "Name",
        .@"type" = "Type",
        .uid = "Uid",
    };
};
