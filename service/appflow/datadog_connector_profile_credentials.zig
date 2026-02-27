/// The connector-specific credentials required by Datadog.
pub const DatadogConnectorProfileCredentials = struct {
    /// A unique alphanumeric identifier used to authenticate a user, developer, or
    /// calling
    /// program to your API.
    api_key: []const u8,

    /// Application keys, in conjunction with your API key, give you full access to
    /// Datadog’s
    /// programmatic API. Application keys are associated with the user account that
    /// created them. The
    /// application key is used to log all requests made to the API.
    application_key: []const u8,

    pub const json_field_names = .{
        .api_key = "apiKey",
        .application_key = "applicationKey",
    };
};
