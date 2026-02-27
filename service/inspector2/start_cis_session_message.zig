/// The start CIS session message.
pub const StartCisSessionMessage = struct {
    /// The unique token that identifies the CIS session.
    session_token: []const u8,

    pub const json_field_names = .{
        .session_token = "sessionToken",
    };
};
