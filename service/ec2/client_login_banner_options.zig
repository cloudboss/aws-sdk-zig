/// Options for enabling a customizable text banner that will be displayed on
/// Amazon Web Services provided clients when a VPN session is established.
pub const ClientLoginBannerOptions = struct {
    /// Customizable text that will be displayed in a banner on Amazon Web Services
    /// provided
    /// clients when a VPN session is established. UTF-8 encoded characters only.
    /// Maximum of
    /// 1400 characters.
    banner_text: ?[]const u8,

    /// Enable or disable a customizable text banner that will be displayed on
    /// Amazon Web Services provided clients when a VPN session is established.
    ///
    /// Valid values: `true | false`
    ///
    /// Default value: `false`
    enabled: ?bool,
};
