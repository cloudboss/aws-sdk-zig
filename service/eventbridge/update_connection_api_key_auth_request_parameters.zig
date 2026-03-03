/// Contains the API key authorization parameters to use to update the
/// connection.
pub const UpdateConnectionApiKeyAuthRequestParameters = struct {
    /// The name of the API key to use for authorization.
    api_key_name: ?[]const u8 = null,

    /// The value associated with the API key to use for authorization.
    api_key_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_key_name = "ApiKeyName",
        .api_key_value = "ApiKeyValue",
    };
};
