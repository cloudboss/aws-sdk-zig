const ExpressGatewayServiceAwsLogsConfiguration = @import("express_gateway_service_aws_logs_configuration.zig").ExpressGatewayServiceAwsLogsConfiguration;
const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;
const ExpressGatewayRepositoryCredentials = @import("express_gateway_repository_credentials.zig").ExpressGatewayRepositoryCredentials;
const Secret = @import("secret.zig").Secret;

/// Defines the configuration for the primary container in an Express service.
/// This container
/// receives traffic from the Application Load Balancer and runs your
/// application code.
///
/// The container configuration includes the container image, port mapping,
/// logging
/// settings, environment variables, and secrets. The container image is the
/// only required
/// parameter, with sensible defaults provided for other settings.
pub const ExpressGatewayContainer = struct {
    /// The log configuration for the container.
    aws_logs_configuration: ?ExpressGatewayServiceAwsLogsConfiguration = null,

    /// The command that is passed to the container.
    command: ?[]const []const u8 = null,

    /// The port number on the container that receives traffic from the load
    /// balancer. Default
    /// is 80.
    container_port: ?i32 = null,

    /// The environment variables to pass to the container.
    environment: ?[]const KeyValuePair = null,

    /// The image used to start a container. This string is passed directly to the
    /// Docker
    /// daemon. Images in the Docker Hub registry are available by default. Other
    /// repositories are
    /// specified with either `repository-url/image:tag` or
    /// `repository-url/image@digest`.
    ///
    /// For Express services, the image typically contains a web application that
    /// listens on the
    /// specified container port. The image can be stored in Amazon ECR, Docker Hub,
    /// or any other
    /// container registry accessible to your execution role.
    image: []const u8,

    /// The configuration for repository credentials for private registry
    /// authentication.
    repository_credentials: ?ExpressGatewayRepositoryCredentials = null,

    /// The secrets to pass to the container.
    secrets: ?[]const Secret = null,

    pub const json_field_names = .{
        .aws_logs_configuration = "awsLogsConfiguration",
        .command = "command",
        .container_port = "containerPort",
        .environment = "environment",
        .image = "image",
        .repository_credentials = "repositoryCredentials",
        .secrets = "secrets",
    };
};
