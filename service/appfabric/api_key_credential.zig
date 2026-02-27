/// Contains API key credential information.
pub const ApiKeyCredential = struct {
    /// An API key for an application.
    api_key: []const u8,

    pub const json_field_names = .{
        .api_key = "apiKey",
    };
};
