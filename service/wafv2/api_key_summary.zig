/// Information for a single API key.
///
/// API keys are required for the integration of the CAPTCHA API in your
/// JavaScript client applications.
/// The API lets you customize the placement and characteristics of the CAPTCHA
/// puzzle for your end users.
/// For more information about the CAPTCHA JavaScript integration, see [WAF
/// client application
/// integration](https://docs.aws.amazon.com/waf/latest/developerguide/waf-application-integration.html) in the *WAF Developer Guide*.
pub const APIKeySummary = struct {
    /// The generated, encrypted API key. You can copy this for use in your
    /// JavaScript CAPTCHA integration.
    api_key: ?[]const u8,

    /// The date and time that the key was created.
    creation_timestamp: ?i64,

    /// The token domains that are defined in this API key.
    token_domains: ?[]const []const u8,

    /// Internal value used by WAF to manage the key.
    version: i32 = 0,

    pub const json_field_names = .{
        .api_key = "APIKey",
        .creation_timestamp = "CreationTimestamp",
        .token_domains = "TokenDomains",
        .version = "Version",
    };
};
