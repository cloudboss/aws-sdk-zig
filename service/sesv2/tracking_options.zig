const HttpsPolicy = @import("https_policy.zig").HttpsPolicy;

/// An object that defines the tracking options for a configuration set. When
/// you use the
/// Amazon SES API v2 to send an email, it contains an invisible image that's
/// used to track when
/// recipients open your email. If your email contains links, those links are
/// changed
/// slightly in order to track when recipients click them.
///
/// These images and links include references to a domain operated by Amazon Web
/// Services. You can
/// optionally configure the Amazon SES to use a domain that you operate for
/// these images and
/// links.
pub const TrackingOptions = struct {
    /// The domain to use for tracking open and click events.
    custom_redirect_domain: []const u8,

    /// The https policy to use for tracking open and click events.
    https_policy: ?HttpsPolicy = null,

    pub const json_field_names = .{
        .custom_redirect_domain = "CustomRedirectDomain",
        .https_policy = "HttpsPolicy",
    };
};
