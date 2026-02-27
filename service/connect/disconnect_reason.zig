/// Contains details about why a contact was disconnected. Only Amazon Connect
/// outbound campaigns can provide
/// this field.
pub const DisconnectReason = struct {
    /// A code that indicates how the contact was terminated.
    code: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
    };
};
