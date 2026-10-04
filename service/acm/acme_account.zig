const AcmeAccountStatus = @import("acme_account_status.zig").AcmeAccountStatus;

/// Contains detailed information about an ACME account.
pub const AcmeAccount = struct {
    /// The URL of the ACME account.
    account_url: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the external account binding associated
    /// with this ACME account.
    acme_external_account_binding_arn: ?[]const u8 = null,

    /// The contact information for the ACME account.
    contacts: ?[]const []const u8 = null,

    /// The time at which the ACME account was created.
    created_at: ?i64 = null,

    /// The thumbprint of the public key associated with the ACME account.
    public_key_thumbprint: ?[]const u8 = null,

    /// The status of the ACME account.
    status: ?AcmeAccountStatus = null,

    pub const json_field_names = .{
        .account_url = "AccountUrl",
        .acme_external_account_binding_arn = "AcmeExternalAccountBindingArn",
        .contacts = "Contacts",
        .created_at = "CreatedAt",
        .public_key_thumbprint = "PublicKeyThumbprint",
        .status = "Status",
    };
};
