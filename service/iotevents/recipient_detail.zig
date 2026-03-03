const SSOIdentity = @import("sso_identity.zig").SSOIdentity;

/// The information that identifies the recipient.
pub const RecipientDetail = struct {
    /// The AWS Single Sign-On (AWS SSO) authentication information.
    sso_identity: ?SSOIdentity = null,

    pub const json_field_names = .{
        .sso_identity = "ssoIdentity",
    };
};
