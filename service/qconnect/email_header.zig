/// The email header to include in email messages.
pub const EmailHeader = struct {
    /// The name of the email header.
    name: ?[]const u8 = null,

    /// The value of the email header.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
