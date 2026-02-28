const EnvironmentVariableType = @import("environment_variable_type.zig").EnvironmentVariableType;

/// The environment variables for the action.
pub const EnvironmentVariable = struct {
    /// The environment variable name in the key-value pair.
    name: []const u8,

    /// Specifies the type of use for the environment variable value. The value can
    /// be either
    /// `PLAINTEXT` or `SECRETS_MANAGER`. If the value is `SECRETS_MANAGER`, provide
    /// the Secrets
    /// reference in the EnvironmentVariable value.
    type: ?EnvironmentVariableType,

    /// The environment variable value in the key-value pair.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
        .value = "value",
    };
};
