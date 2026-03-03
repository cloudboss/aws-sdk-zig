const AwsCodeBuildProjectArtifactsDetails = @import("aws_code_build_project_artifacts_details.zig").AwsCodeBuildProjectArtifactsDetails;
const AwsCodeBuildProjectEnvironment = @import("aws_code_build_project_environment.zig").AwsCodeBuildProjectEnvironment;
const AwsCodeBuildProjectLogsConfigDetails = @import("aws_code_build_project_logs_config_details.zig").AwsCodeBuildProjectLogsConfigDetails;
const AwsCodeBuildProjectSource = @import("aws_code_build_project_source.zig").AwsCodeBuildProjectSource;
const AwsCodeBuildProjectVpcConfig = @import("aws_code_build_project_vpc_config.zig").AwsCodeBuildProjectVpcConfig;

/// Information about an CodeBuild project.
pub const AwsCodeBuildProjectDetails = struct {
    /// Information about the build artifacts for the CodeBuild project.
    artifacts: ?[]const AwsCodeBuildProjectArtifactsDetails = null,

    /// The KMS key used to encrypt the
    /// build output artifacts.
    ///
    /// You can specify either the ARN of the KMS key or, if available, the
    /// KMS key alias (using the format alias/alias-name).
    encryption_key: ?[]const u8 = null,

    /// Information about the build environment for this build project.
    environment: ?AwsCodeBuildProjectEnvironment = null,

    /// Information about logs for the build project.
    logs_config: ?AwsCodeBuildProjectLogsConfigDetails = null,

    /// The name of the build project.
    name: ?[]const u8 = null,

    /// Information about the secondary artifacts for the CodeBuild project.
    secondary_artifacts: ?[]const AwsCodeBuildProjectArtifactsDetails = null,

    /// The ARN of the IAM role that enables CodeBuild to interact with dependent
    /// Amazon Web Services
    /// services on behalf of the Amazon Web Services account.
    service_role: ?[]const u8 = null,

    /// Information about the build input source code for this build project.
    source: ?AwsCodeBuildProjectSource = null,

    /// Information about the VPC configuration that CodeBuild accesses.
    vpc_config: ?AwsCodeBuildProjectVpcConfig = null,

    pub const json_field_names = .{
        .artifacts = "Artifacts",
        .encryption_key = "EncryptionKey",
        .environment = "Environment",
        .logs_config = "LogsConfig",
        .name = "Name",
        .secondary_artifacts = "SecondaryArtifacts",
        .service_role = "ServiceRole",
        .source = "Source",
        .vpc_config = "VpcConfig",
    };
};
