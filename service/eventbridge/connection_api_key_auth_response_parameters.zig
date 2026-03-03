/// Contains the authorization parameters for the connection if API Key is
/// specified as the
/// authorization type.
pub const ConnectionApiKeyAuthResponseParameters = struct {
    /// The name of the header to use for the `APIKeyValue` used for
    /// authorization.
    api_key_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_key_name = "ApiKeyName",
    };
};
