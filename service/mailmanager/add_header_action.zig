/// The action to add a header to a message. When executed, this action will add
/// the given header to the message.
pub const AddHeaderAction = struct {
    /// The name of the header to add to an email. The header must be prefixed with
    /// "X-". Headers are added regardless of whether the header name pre-existed in
    /// the email.
    header_name: []const u8,

    /// The value of the header to add to the email.
    header_value: []const u8,

    pub const json_field_names = .{
        .header_name = "HeaderName",
        .header_value = "HeaderValue",
    };
};
