pub const WebhookAuthenticationType = enum {
    github_hmac,
    ip,
    unauthenticated,

    pub const json_field_names = .{
        .github_hmac = "GITHUB_HMAC",
        .ip = "IP",
        .unauthenticated = "UNAUTHENTICATED",
    };
};
