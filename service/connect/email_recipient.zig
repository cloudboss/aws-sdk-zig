/// Information about the email recipient
pub const EmailRecipient = struct {
    /// Address of the email recipient.
    address: ?[]const u8,

    /// Display name of the email recipient.
    display_name: ?[]const u8,

    pub const json_field_names = .{
        .address = "Address",
        .display_name = "DisplayName",
    };
};
