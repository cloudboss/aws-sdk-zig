/// A plain text RCS message body.
pub const RcsTextMessage = struct {
    /// The text body of the RCS message. Maximum 3072 characters.
    body: []const u8,

    pub const json_field_names = .{
        .body = "Body",
    };
};
