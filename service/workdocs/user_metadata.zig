/// Describes the metadata of the user.
pub const UserMetadata = struct {
    /// The email address of the user.
    email_address: ?[]const u8 = null,

    /// The given name of the user before a rename operation.
    given_name: ?[]const u8 = null,

    /// The ID of the user.
    id: ?[]const u8 = null,

    /// The surname of the user.
    surname: ?[]const u8 = null,

    /// The name of the user.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .email_address = "EmailAddress",
        .given_name = "GivenName",
        .id = "Id",
        .surname = "Surname",
        .username = "Username",
    };
};
