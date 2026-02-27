const AwsCodeBuildProjectEnvironmentEnvironmentVariablesDetails = @import("aws_code_build_project_environment_environment_variables_details.zig").AwsCodeBuildProjectEnvironmentEnvironmentVariablesDetails;
const AwsCodeBuildProjectEnvironmentRegistryCredential = @import("aws_code_build_project_environment_registry_credential.zig").AwsCodeBuildProjectEnvironmentRegistryCredential;

/// Information about the build environment for this build project.
pub const AwsCodeBuildProjectEnvironment = struct {
    /// The certificate to use with this build project.
    certificate: ?[]const u8,

    /// A set of environment variables to make available to builds for the build
    /// project.
    environment_variables: ?[]const AwsCodeBuildProjectEnvironmentEnvironmentVariablesDetails,

    /// The type of credentials CodeBuild uses to pull images in your build.
    ///
    /// Valid values:
    ///
    /// * `CODEBUILD` specifies that CodeBuild uses its own credentials. This
    /// requires that you modify your ECR repository policy to trust the CodeBuild
    /// service principal.
    ///
    /// * `SERVICE_ROLE` specifies that CodeBuild uses your build project's
    /// service role.
    ///
    /// When you use a cross-account or private registry image, you must use
    /// `SERVICE_ROLE` credentials. When you use an CodeBuild curated image, you
    /// must use `CODEBUILD` credentials.
    image_pull_credentials_type: ?[]const u8,

    /// Whether to allow the Docker daemon to run inside a Docker container. Set to
    /// `true` if the build project is used to build Docker images.
    privileged_mode: ?bool,

    /// The credentials for access to a private registry.
    registry_credential: ?AwsCodeBuildProjectEnvironmentRegistryCredential,

    /// The type of build environment to use for related builds.
    ///
    /// The environment type `ARM_CONTAINER` is available only in Regions US East
    /// (N.
    /// Virginia), US East (Ohio), US West (Oregon), Europe (Ireland), Asia Pacific
    /// (Mumbai), Asia
    /// Pacific (Tokyo), Asia Pacific (Sydney), and Europe (Frankfurt).
    ///
    /// The environment type `LINUX_CONTAINER` with compute type
    /// build.general1.2xlarge is available only in Regions US East (N. Virginia),
    /// US East (N.
    /// Virginia), US West (Oregon), Canada (Central), Europe (Ireland), Europe
    /// (London), Europe
    /// (Frankfurt), Asia Pacific (Tokyo), Asia Pacific (Seoul), Asia Pacific
    /// (Singapore), Asia
    /// Pacific (Sydney), China (Beijing), and China (Ningxia).
    ///
    /// The environment type `LINUX_GPU_CONTAINER` is available only in Regions US
    /// East (N. Virginia), US East (N. Virginia), US West (Oregon), Canada
    /// (Central), Europe
    /// (Ireland), Europe (London), Europe (Frankfurt), Asia Pacific (Tokyo), Asia
    /// Pacific (Seoul),
    /// Asia Pacific (Singapore), Asia Pacific (Sydney), China (Beijing), and China
    /// (Ningxia).
    ///
    /// Valid values: `WINDOWS_CONTAINER` | `LINUX_CONTAINER` |
    /// `LINUX_GPU_CONTAINER` | `ARM_CONTAINER`
    type: ?[]const u8,

    pub const json_field_names = .{
        .certificate = "Certificate",
        .environment_variables = "EnvironmentVariables",
        .image_pull_credentials_type = "ImagePullCredentialsType",
        .privileged_mode = "PrivilegedMode",
        .registry_credential = "RegistryCredential",
        .type = "Type",
    };
};
