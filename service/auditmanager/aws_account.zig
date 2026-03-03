/// The wrapper of Amazon Web Services account details, such as account ID or
/// email address.
pub const AWSAccount = struct {
    /// The email address that's associated with the Amazon Web Services account.
    email_address: ?[]const u8 = null,

    /// The identifier for the Amazon Web Services account.
    id: ?[]const u8 = null,

    /// The name of the Amazon Web Services account.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .email_address = "emailAddress",
        .id = "id",
        .name = "name",
    };
};
