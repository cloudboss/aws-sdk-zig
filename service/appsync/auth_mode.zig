const AuthenticationType = @import("authentication_type.zig").AuthenticationType;

/// Describes an authorization configuration. Use `AuthMode` to specify the
/// publishing and subscription authorization configuration for an Event API.
pub const AuthMode = struct {
    /// The authorization type.
    auth_type: AuthenticationType,

    pub const json_field_names = .{
        .auth_type = "authType",
    };
};
