const BuildArtifacts = @import("build_artifacts.zig").BuildArtifacts;
const AutoRetryConfig = @import("auto_retry_config.zig").AutoRetryConfig;
const StatusType = @import("status_type.zig").StatusType;
const ProjectCache = @import("project_cache.zig").ProjectCache;
const DebugSession = @import("debug_session.zig").DebugSession;
const ProjectEnvironment = @import("project_environment.zig").ProjectEnvironment;
const ExportedEnvironmentVariable = @import("exported_environment_variable.zig").ExportedEnvironmentVariable;
const ProjectFileSystemLocation = @import("project_file_system_location.zig").ProjectFileSystemLocation;
const LogsLocation = @import("logs_location.zig").LogsLocation;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const BuildPhase = @import("build_phase.zig").BuildPhase;
const ProjectSource = @import("project_source.zig").ProjectSource;
const ProjectSourceVersion = @import("project_source_version.zig").ProjectSourceVersion;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Information about a build.
pub const Build = struct {
    /// The Amazon Resource Name (ARN) of the build.
    arn: ?[]const u8 = null,

    /// Information about the output artifacts for the build.
    artifacts: ?BuildArtifacts = null,

    /// Information about the auto-retry configuration for the build.
    auto_retry_config: ?AutoRetryConfig = null,

    /// The ARN of the batch build that this build is a member of, if applicable.
    build_batch_arn: ?[]const u8 = null,

    /// Whether the build is complete. True if complete; otherwise, false.
    build_complete: bool = false,

    /// The number of the build. For each project, the `buildNumber` of its first
    /// build is `1`. The `buildNumber` of each subsequent build is
    /// incremented by `1`. If a build is deleted, the `buildNumber` of
    /// other builds does not change.
    build_number: ?i64 = null,

    /// The current status of the build. Valid values include:
    ///
    /// * `FAILED`: The build failed.
    ///
    /// * `FAULT`: The build faulted.
    ///
    /// * `IN_PROGRESS`: The build is still in progress.
    ///
    /// * `STOPPED`: The build stopped.
    ///
    /// * `SUCCEEDED`: The build succeeded.
    ///
    /// * `TIMED_OUT`: The build timed out.
    build_status: ?StatusType = null,

    /// Information about the cache for the build.
    cache: ?ProjectCache = null,

    /// The current build phase.
    current_phase: ?[]const u8 = null,

    /// Contains information about the debug session for this build.
    debug_session: ?DebugSession = null,

    /// The Key Management Service customer master key (CMK) to be used for
    /// encrypting the build output
    /// artifacts.
    ///
    /// You can use a cross-account KMS key to encrypt the build output artifacts if
    /// your
    /// service role has permission to that key.
    ///
    /// You can specify either the Amazon Resource Name (ARN) of the CMK or, if
    /// available, the CMK's alias (using
    /// the format `alias/`).
    encryption_key: ?[]const u8 = null,

    /// When the build process ended, expressed in Unix time format.
    end_time: ?i64 = null,

    /// Information about the build environment for this build.
    environment: ?ProjectEnvironment = null,

    /// A list of exported environment variables for this build.
    ///
    /// Exported environment variables are used in conjunction with CodePipeline to
    /// export
    /// environment variables from the current build stage to subsequent stages in
    /// the pipeline.
    /// For more information, see [Working with
    /// variables](https://docs.aws.amazon.com/codepipeline/latest/userguide/actions-variables.html) in the *CodePipeline User Guide*.
    exported_environment_variables: ?[]const ExportedEnvironmentVariable = null,

    /// An array of `ProjectFileSystemLocation` objects for a CodeBuild build
    /// project. A `ProjectFileSystemLocation` object
    /// specifies the `identifier`, `location`, `mountOptions`,
    /// `mountPoint`, and `type` of a file system created using Amazon Elastic File
    /// System.
    file_system_locations: ?[]const ProjectFileSystemLocation = null,

    /// The unique ID for the build.
    id: ?[]const u8 = null,

    /// The entity that started the build. Valid values include:
    ///
    /// * If CodePipeline started the build, the pipeline's name (for example,
    /// `codepipeline/my-demo-pipeline`).
    ///
    /// * If a user started the build, the user's name (for example,
    /// `MyUserName`).
    ///
    /// * If the Jenkins plugin for CodeBuild started the build, the string
    /// `CodeBuild-Jenkins-Plugin`.
    initiator: ?[]const u8 = null,

    /// Information about the build's logs in CloudWatch Logs.
    logs: ?LogsLocation = null,

    /// Describes a network interface.
    network_interface: ?NetworkInterface = null,

    /// Information about all previous build phases that are complete and
    /// information about
    /// any current build phase that is not yet complete.
    phases: ?[]const BuildPhase = null,

    /// The name of the CodeBuild project.
    project_name: ?[]const u8 = null,

    /// The number of minutes a build is allowed to be queued before it times out.
    queued_timeout_in_minutes: ?i32 = null,

    /// An array of the ARNs associated with this build's reports.
    report_arns: ?[]const []const u8 = null,

    /// An identifier for the version of this build's source code.
    ///
    /// * For CodeCommit, GitHub, GitHub Enterprise, and BitBucket, the commit ID.
    ///
    /// * For CodePipeline, the source revision provided by CodePipeline.
    ///
    /// * For Amazon S3, this does not apply.
    resolved_source_version: ?[]const u8 = null,

    /// An array of `ProjectArtifacts` objects.
    secondary_artifacts: ?[]const BuildArtifacts = null,

    /// An array of `ProjectSource` objects.
    secondary_sources: ?[]const ProjectSource = null,

    /// An array of `ProjectSourceVersion` objects. Each
    /// `ProjectSourceVersion` must be one of:
    ///
    /// * For CodeCommit: the commit ID, branch, or Git tag to use.
    ///
    /// * For GitHub: the commit ID, pull request ID, branch name, or tag name that
    /// corresponds to the version of the source code you want to build. If a pull
    /// request ID is specified, it must use the format `pr/pull-request-ID`
    /// (for example, `pr/25`). If a branch name is specified, the branch's
    /// HEAD commit ID is used. If not specified, the default branch's HEAD commit
    /// ID is
    /// used.
    ///
    /// * For Bitbucket: the commit ID, branch name, or tag name that corresponds to
    ///   the
    /// version of the source code you want to build. If a branch name is specified,
    /// the
    /// branch's HEAD commit ID is used. If not specified, the default branch's HEAD
    /// commit ID is used.
    ///
    /// * For Amazon S3: the version ID of the object that represents the build
    ///   input ZIP
    /// file to use.
    secondary_source_versions: ?[]const ProjectSourceVersion = null,

    /// The name of a service role used for this build.
    service_role: ?[]const u8 = null,

    /// Information about the source code to be built.
    source: ?ProjectSource = null,

    /// Any version identifier for the version of the source code to be built. If
    /// `sourceVersion` is specified at the project level, then this
    /// `sourceVersion` (at the build level) takes precedence.
    ///
    /// For more information, see [Source Version Sample
    /// with
    /// CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-source-version.html) in the *CodeBuild User Guide*.
    source_version: ?[]const u8 = null,

    /// When the build process started, expressed in Unix time format.
    start_time: ?i64 = null,

    /// How long, in minutes, from 5 to 2160 (36 hours), for CodeBuild to wait
    /// before timing out this build if it does not
    /// get marked as completed.
    timeout_in_minutes: ?i32 = null,

    /// If your CodeBuild project accesses resources in an Amazon VPC, you provide
    /// this parameter
    /// that identifies the VPC ID and the list of security group IDs and subnet
    /// IDs. The
    /// security groups and subnets must belong to the same VPC. You must provide at
    /// least one
    /// security group and one subnet ID.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .arn = "arn",
        .artifacts = "artifacts",
        .auto_retry_config = "autoRetryConfig",
        .build_batch_arn = "buildBatchArn",
        .build_complete = "buildComplete",
        .build_number = "buildNumber",
        .build_status = "buildStatus",
        .cache = "cache",
        .current_phase = "currentPhase",
        .debug_session = "debugSession",
        .encryption_key = "encryptionKey",
        .end_time = "endTime",
        .environment = "environment",
        .exported_environment_variables = "exportedEnvironmentVariables",
        .file_system_locations = "fileSystemLocations",
        .id = "id",
        .initiator = "initiator",
        .logs = "logs",
        .network_interface = "networkInterface",
        .phases = "phases",
        .project_name = "projectName",
        .queued_timeout_in_minutes = "queuedTimeoutInMinutes",
        .report_arns = "reportArns",
        .resolved_source_version = "resolvedSourceVersion",
        .secondary_artifacts = "secondaryArtifacts",
        .secondary_sources = "secondarySources",
        .secondary_source_versions = "secondarySourceVersions",
        .service_role = "serviceRole",
        .source = "source",
        .source_version = "sourceVersion",
        .start_time = "startTime",
        .timeout_in_minutes = "timeoutInMinutes",
        .vpc_config = "vpcConfig",
    };
};
