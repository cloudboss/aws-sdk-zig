/// Settings for for a PULL type input.
pub const InputSourceRequest = struct {
    /// The key used to extract the password from EC2 Parameter store.
    password_param: ?[]const u8 = null,

    /// This represents the customer's source URL where stream is
    /// pulled from.
    url: ?[]const u8 = null,

    /// The username for the input source.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .password_param = "PasswordParam",
        .url = "Url",
        .username = "Username",
    };
};
