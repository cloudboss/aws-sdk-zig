/// StripePrivy token request parameters
pub const StripePrivyTokenRequestInput = struct {
    /// Set to true to generate privy-authorization-signature
    include_authorization_signature: bool = false,

    /// Request body JSON for the Privy API call
    request_body: []const u8,

    /// Optional - defaults to "api.privy.io"
    request_host: ?[]const u8 = null,

    /// The path of the Stripe Privy API request.
    request_path: []const u8,

    pub const json_field_names = .{
        .include_authorization_signature = "includeAuthorizationSignature",
        .request_body = "requestBody",
        .request_host = "requestHost",
        .request_path = "requestPath",
    };
};
