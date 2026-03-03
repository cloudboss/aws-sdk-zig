/// Information about the email recipient
pub const EmailRecipient = struct {
    /// Address of the email recipient.
    address: ?[]const u8 = null,

    /// Display name of the email recipient.
    display_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .address = "Address",
        .display_name = "DisplayName",
    };
};
