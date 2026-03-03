const EnvironmentVariableType = @import("environment_variable_type.zig").EnvironmentVariableType;

/// Information about an environment variable for a build project or a build.
pub const EnvironmentVariable = struct {
    /// The name or key of the environment variable.
    name: []const u8,

    /// The type of environment variable. Valid values include:
    ///
    /// * `PARAMETER_STORE`: An environment variable stored in Systems Manager
    /// Parameter Store. For environment variables of this type, specify the name of
    /// the parameter as the `value` of the
    /// EnvironmentVariable. The parameter value will be substituted for the name at
    /// runtime. You can also define Parameter
    /// Store environment variables in the buildspec. To learn how to do so,
    /// see
    /// [env/parameter-store](https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html#build-spec.env.parameter-store) in the
    /// *CodeBuild User Guide*.
    ///
    /// * `PLAINTEXT`: An environment variable in plain text format. This is
    /// the default value.
    ///
    /// * `SECRETS_MANAGER`: An environment variable stored in Secrets Manager. For
    ///   environment variables of this type,
    /// specify the name of the secret as the `value` of the EnvironmentVariable.
    /// The secret value will be substituted for the
    /// name at runtime. You can also define Secrets Manager environment variables
    /// in the buildspec. To learn how to do so, see
    /// [env/secrets-manager](https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html#build-spec.env.secrets-manager) in the
    /// *CodeBuild User Guide*.
    @"type": ?EnvironmentVariableType = null,

    /// The value of the environment variable.
    ///
    /// We strongly discourage the use of `PLAINTEXT` environment variables to
    /// store sensitive values, especially Amazon Web Services secret key IDs.
    /// `PLAINTEXT` environment variables can be displayed in plain text
    /// using the CodeBuild console and the CLI. For sensitive values, we recommend
    /// you use an
    /// environment variable of type `PARAMETER_STORE` or
    /// `SECRETS_MANAGER`.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
        .value = "value",
    };
};
