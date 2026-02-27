/// An object that defines the tracking options for a configuration set. When
/// you use
/// Amazon Pinpoint to send an email, it contains an invisible image that's used
/// to track when
/// recipients open your email. If your email contains links, those links are
/// changed
/// slightly in order to track when recipients click them.
///
/// These images and links include references to a domain operated by AWS. You
/// can
/// optionally configure Amazon Pinpoint to use a domain that you operate for
/// these images and
/// links.
pub const TrackingOptions = struct {
    /// The domain that you want to use for tracking open and click events.
    custom_redirect_domain: []const u8,

    pub const json_field_names = .{
        .custom_redirect_domain = "CustomRedirectDomain",
    };
};
