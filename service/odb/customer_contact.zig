/// A contact to receive notification from Oracle about maintenance updates for
/// a specific Exadata infrastructure.
pub const CustomerContact = struct {
    /// The email address of the contact.
    email: ?[]const u8 = null,

    pub const json_field_names = .{
        .email = "email",
    };
};
