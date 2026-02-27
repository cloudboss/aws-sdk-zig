/// Contains the API key authorization parameters for the connection.
pub const CreateConnectionApiKeyAuthRequestParameters = struct {
    /// The name of the API key to use for authorization.
    api_key_name: []const u8,

    /// The value for the API key to use for authorization.
    api_key_value: []const u8,

    pub const json_field_names = .{
        .api_key_name = "ApiKeyName",
        .api_key_value = "ApiKeyValue",
    };
};
