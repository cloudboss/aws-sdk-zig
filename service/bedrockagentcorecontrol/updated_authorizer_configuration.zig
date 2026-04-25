const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;

/// Wrapper for updating an optional AuthorizerConfiguration field with PATCH
/// semantics. When present in an update request, the authorizer configuration
/// is replaced with optionalValue. When absent, the authorizer configuration is
/// left unchanged. To unset, include the wrapper with optionalValue not
/// specified.
pub const UpdatedAuthorizerConfiguration = struct {
    /// The updated authorizer configuration value. If not specified, it will clear
    /// the current authorizer configuration of the resource.
    optional_value: ?AuthorizerConfiguration = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
