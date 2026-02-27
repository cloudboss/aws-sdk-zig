const aws = @import("aws");

const Runtime = @import("runtime.zig").Runtime;

/// Describes the basic configuration needed for building and running an App
/// Runner service. This type doesn't support the full set of possible
/// configuration options. Fur full configuration capabilities, use a
/// `apprunner.yaml` file in the source code repository.
pub const CodeConfigurationValues = struct {
    /// The command App Runner runs to build your
    /// application.
    build_command: ?[]const u8,

    /// The port that your application listens to in the container.
    ///
    /// Default: `8080`
    port: ?[]const u8,

    /// A runtime environment type for building and running an App Runner service.
    /// It represents a
    /// programming language runtime.
    runtime: Runtime,

    /// An array of key-value pairs representing the secrets and parameters that get
    /// referenced to your service as an environment variable. The supported
    /// values are either the full Amazon Resource Name (ARN) of the Secrets Manager
    /// secret or the full ARN of the parameter in the Amazon Web Services Systems
    /// Manager
    /// Parameter Store.
    ///
    /// * If the Amazon Web Services Systems Manager Parameter Store parameter
    ///   exists in the same Amazon Web Services Region as the service that you're
    ///   launching, you can use
    /// either the full ARN or name of the secret. If the parameter exists in a
    /// different Region, then the full ARN must be specified.
    ///
    /// * Currently, cross account referencing of Amazon Web Services Systems
    ///   Manager Parameter Store parameter is not supported.
    runtime_environment_secrets: ?[]const aws.map.StringMapEntry,

    /// The environment variables that are available to your running App Runner
    /// service. An array of key-value pairs.
    runtime_environment_variables: ?[]const aws.map.StringMapEntry,

    /// The command App Runner runs to start your
    /// application.
    start_command: ?[]const u8,

    pub const json_field_names = .{
        .build_command = "BuildCommand",
        .port = "Port",
        .runtime = "Runtime",
        .runtime_environment_secrets = "RuntimeEnvironmentSecrets",
        .runtime_environment_variables = "RuntimeEnvironmentVariables",
        .start_command = "StartCommand",
    };
};
