const IdentityType = @import("identity_type.zig").IdentityType;

/// Information about an email identity.
pub const IdentityInfo = struct {
    /// The address or domain of the identity.
    identity_name: ?[]const u8 = null,

    /// The email identity type. The identity type can be one of the following:
    ///
    /// * `EMAIL_ADDRESS` – The identity is an email address.
    ///
    /// * `DOMAIN` – The identity is a domain.
    ///
    /// * `MANAGED_DOMAIN` – The identity is a domain that is managed
    /// by AWS.
    identity_type: ?IdentityType = null,

    /// Indicates whether or not you can send email from the identity.
    ///
    /// In Amazon Pinpoint, an identity is an email address or domain that you send
    /// email from. Before
    /// you can send email from an identity, you have to demostrate that you own the
    /// identity,
    /// and that you authorize Amazon Pinpoint to send email from that identity.
    sending_enabled: bool = false,

    pub const json_field_names = .{
        .identity_name = "IdentityName",
        .identity_type = "IdentityType",
        .sending_enabled = "SendingEnabled",
    };
};
