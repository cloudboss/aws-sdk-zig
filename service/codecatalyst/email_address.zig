/// Information about an email address.
pub const EmailAddress = struct {
    /// The email address.
    email: ?[]const u8 = null,

    /// Whether the email address has been verified.
    verified: ?bool = null,

    pub const json_field_names = .{
        .email = "email",
        .verified = "verified",
    };
};
