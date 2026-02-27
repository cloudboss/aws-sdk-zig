/// An object that describes the recipients for an email.
pub const Destination = struct {
    /// An array that contains the email addresses of the "BCC" (blind carbon copy)
    /// recipients
    /// for the email.
    bcc_addresses: ?[]const []const u8,

    /// An array that contains the email addresses of the "CC" (carbon copy)
    /// recipients for
    /// the email.
    cc_addresses: ?[]const []const u8,

    /// An array that contains the email addresses of the "To" recipients for the
    /// email.
    to_addresses: ?[]const []const u8,

    pub const json_field_names = .{
        .bcc_addresses = "BccAddresses",
        .cc_addresses = "CcAddresses",
        .to_addresses = "ToAddresses",
    };
};
