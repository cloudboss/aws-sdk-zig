/// LinkedAccount using an email address.
pub const LinkedAccountEmail = struct {
    /// The email address used for linkedAccount.
    /// Must be a valid email format.
    email_address: []const u8,

    pub const json_field_names = .{
        .email_address = "emailAddress",
    };
};
