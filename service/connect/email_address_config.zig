/// Configuration object that specifies an email address to be associated with a
/// queue. This configuration contains the identifier of the email address that
/// should be linked to the queue for routing email contacts.
pub const EmailAddressConfig = struct {
    /// The identifier of the email address that should be associated with the
    /// queue. This email address must already exist in the Amazon Connect instance
    /// and will be used to route incoming email contacts to the specified queue.
    email_address_id: []const u8,

    pub const json_field_names = .{
        .email_address_id = "EmailAddressId",
    };
};
