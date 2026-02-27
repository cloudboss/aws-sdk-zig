/// Specifies the "From" address for an email message that's sent to
/// participants in a journey.
pub const JourneyEmailMessage = struct {
    /// The verified email address to send the email message from. The default
    /// address is the FromAddress specified for the email channel for the
    /// application.
    from_address: ?[]const u8,

    pub const json_field_names = .{
        .from_address = "FromAddress",
    };
};
