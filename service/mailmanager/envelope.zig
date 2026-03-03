/// The SMTP envelope information of the email.
pub const Envelope = struct {
    /// The RCPT FROM given by the host from which the email was received.
    from: ?[]const u8 = null,

    /// The HELO used by the host from which the email was received.
    helo: ?[]const u8 = null,

    /// All SMTP TO entries given by the host from which the email was received.
    to: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .from = "From",
        .helo = "Helo",
        .to = "To",
    };
};
