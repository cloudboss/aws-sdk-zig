/// The rules to redirect the request if the condition in `Condition` is
/// met.
pub const AwsS3BucketWebsiteConfigurationRoutingRuleRedirect = struct {
    /// The host name to use in the redirect request.
    hostname: ?[]const u8 = null,

    /// The HTTP redirect code to use in the response.
    http_redirect_code: ?[]const u8 = null,

    /// The protocol to use to redirect the request. By default, uses the protocol
    /// from the
    /// original request.
    protocol: ?[]const u8 = null,

    /// The object key prefix to use in the redirect request.
    ///
    /// Cannot be provided if `ReplaceKeyWith` is present.
    replace_key_prefix_with: ?[]const u8 = null,

    /// The specific object key to use in the redirect request.
    ///
    /// Cannot be provided if `ReplaceKeyPrefixWith` is present.
    replace_key_with: ?[]const u8 = null,

    pub const json_field_names = .{
        .hostname = "Hostname",
        .http_redirect_code = "HttpRedirectCode",
        .protocol = "Protocol",
        .replace_key_prefix_with = "ReplaceKeyPrefixWith",
        .replace_key_with = "ReplaceKeyWith",
    };
};
