const CognitoConfig = @import("cognito_config.zig").CognitoConfig;
const None = @import("none.zig").None;

/// Represents an authorization configuration for a portal.
pub const Authorization = struct {
    /// The Amazon Cognito configuration.
    cognito_config: ?CognitoConfig = null,

    /// Provide no authorization for your portal. This makes your portal publicly
    /// accesible on the web.
    none: ?None = null,

    pub const json_field_names = .{
        .cognito_config = "CognitoConfig",
        .none = "None",
    };
};
