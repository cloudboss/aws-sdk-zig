const Attachment = @import("attachment.zig").Attachment;

/// Creates a site-to-site VPN attachment.
pub const SiteToSiteVpnAttachment = struct {
    /// Provides details about a site-to-site VPN attachment.
    attachment: ?Attachment = null,

    /// The ARN of the site-to-site VPN attachment.
    vpn_connection_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachment = "Attachment",
        .vpn_connection_arn = "VpnConnectionArn",
    };
};
