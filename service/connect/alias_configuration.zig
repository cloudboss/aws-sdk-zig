/// Configuration information of an email alias.
pub const AliasConfiguration = struct {
    /// The email address ID.
    email_address_id: []const u8,

    pub const json_field_names = .{
        .email_address_id = "EmailAddressId",
    };
};
