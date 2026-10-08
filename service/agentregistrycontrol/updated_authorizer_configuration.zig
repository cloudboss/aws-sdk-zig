const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;

/// Wrapper for updating an optional authorizer configuration with PATCH
/// semantics.
pub const UpdatedAuthorizerConfiguration = struct {
    /// The new authorizer configuration to set. Omit to leave the existing
    /// configuration unchanged.
    optional_value: ?AuthorizerConfiguration = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
