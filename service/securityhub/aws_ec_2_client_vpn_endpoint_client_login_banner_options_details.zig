/// Options for enabling a customizable text banner that will be displayed on
/// Amazon Web Services provided clients when a
/// VPN session is established.
pub const AwsEc2ClientVpnEndpointClientLoginBannerOptionsDetails = struct {
    /// Customizable text that will be displayed in a banner on Amazon Web Services
    /// provided clients when a VPN session is
    /// established.
    banner_text: ?[]const u8,

    /// Current state of text banner feature.
    enabled: ?bool,

    pub const json_field_names = .{
        .banner_text = "BannerText",
        .enabled = "Enabled",
    };
};
