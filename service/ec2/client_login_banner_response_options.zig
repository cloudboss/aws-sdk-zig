/// Current state of options for customizable text banner that will be displayed
/// on
/// Amazon Web Services provided clients when a VPN session is established.
pub const ClientLoginBannerResponseOptions = struct {
    /// Customizable text that will be displayed in a banner on Amazon Web Services
    /// provided
    /// clients when a VPN session is established. UTF-8 encoded
    /// characters only. Maximum of 1400 characters.
    banner_text: ?[]const u8 = null,

    /// Current state of text banner feature.
    ///
    /// Valid values: `true | false`
    enabled: ?bool = null,
};
