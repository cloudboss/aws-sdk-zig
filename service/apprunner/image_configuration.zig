const aws = @import("aws");

/// Describes the configuration that App Runner uses to run an App Runner
/// service using an image pulled from a source image repository.
pub const ImageConfiguration = struct {
    /// The port that your application listens to in the container.
    ///
    /// Default: `8080`
    port: ?[]const u8 = null,

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
    runtime_environment_secrets: ?[]const aws.map.StringMapEntry = null,

    /// Environment variables that are available to your running App Runner service.
    /// An array of key-value pairs.
    runtime_environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// An optional command that App Runner runs to start the application in the
    /// source image. If specified, this command overrides the Docker image’s
    /// default start
    /// command.
    start_command: ?[]const u8 = null,

    pub const json_field_names = .{
        .port = "Port",
        .runtime_environment_secrets = "RuntimeEnvironmentSecrets",
        .runtime_environment_variables = "RuntimeEnvironmentVariables",
        .start_command = "StartCommand",
    };
};
