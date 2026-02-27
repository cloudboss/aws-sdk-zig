const SessionContextAttributes = @import("session_context_attributes.zig").SessionContextAttributes;
const SessionIssuer = @import("session_issuer.zig").SessionIssuer;

/// Provides information about a session that was created for an entity that
/// performed an action by using temporary security credentials.
pub const SessionContext = struct {
    /// The date and time when the credentials were issued, and whether the
    /// credentials were authenticated with a multi-factor authentication (MFA)
    /// device.
    attributes: ?SessionContextAttributes,

    /// The source and type of credentials that were issued to the entity.
    session_issuer: ?SessionIssuer,

    pub const json_field_names = .{
        .attributes = "attributes",
        .session_issuer = "sessionIssuer",
    };
};
