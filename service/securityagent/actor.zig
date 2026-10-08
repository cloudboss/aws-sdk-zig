const Authentication = @import("authentication.zig").Authentication;

/// Represents an actor used during penetration testing. An actor defines a user
/// or entity that interacts with the target application, including
/// authentication credentials and target URIs.
pub const Actor = struct {
    /// The authentication configuration for the actor.
    authentication: ?Authentication = null,

    /// A description of the actor.
    description: ?[]const u8 = null,

    /// Whether email-based MFA is enabled for this actor.
    enable_email_mfa: ?bool = null,

    /// The unique identifier for the actor.
    identifier: ?[]const u8 = null,

    /// Server-generated email forwarding address for receiving MFA codes.
    mfa_forwarding_address: ?[]const u8 = null,

    /// The list of URIs that the actor targets during testing.
    uris: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .authentication = "authentication",
        .description = "description",
        .enable_email_mfa = "enableEmailMfa",
        .identifier = "identifier",
        .mfa_forwarding_address = "mfaForwardingAddress",
        .uris = "uris",
    };
};
