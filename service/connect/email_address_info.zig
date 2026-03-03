/// Contains information about a source or destination email address.
pub const EmailAddressInfo = struct {
    /// The display name of email address.
    display_name: ?[]const u8 = null,

    /// The email address, including the domain.
    email_address: []const u8,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .email_address = "EmailAddress",
    };
};
