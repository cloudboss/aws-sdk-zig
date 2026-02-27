/// The connector-specific profile credentials required when using Singular.
pub const SingularConnectorProfileCredentials = struct {
    /// A unique alphanumeric identifier used to authenticate a user, developer, or
    /// calling
    /// program to your API.
    api_key: []const u8,

    pub const json_field_names = .{
        .api_key = "apiKey",
    };
};
