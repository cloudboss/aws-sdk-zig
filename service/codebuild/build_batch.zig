const BuildArtifacts = @import("build_artifacts.zig").BuildArtifacts;
const ProjectBuildBatchConfig = @import("project_build_batch_config.zig").ProjectBuildBatchConfig;
const StatusType = @import("status_type.zig").StatusType;
const BuildGroup = @import("build_group.zig").BuildGroup;
const ProjectCache = @import("project_cache.zig").ProjectCache;
const ProjectEnvironment = @import("project_environment.zig").ProjectEnvironment;
const ProjectFileSystemLocation = @import("project_file_system_location.zig").ProjectFileSystemLocation;
const LogsConfig = @import("logs_config.zig").LogsConfig;
const BuildBatchPhase = @import("build_batch_phase.zig").BuildBatchPhase;
const ProjectSource = @import("project_source.zig").ProjectSource;
const ProjectSourceVersion = @import("project_source_version.zig").ProjectSourceVersion;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Contains information about a batch build.
pub const BuildBatch = struct {
    /// The ARN of the batch build.
    arn: ?[]const u8,

    /// A `BuildArtifacts` object the defines the build artifacts for this batch
    /// build.
    artifacts: ?BuildArtifacts,

    build_batch_config: ?ProjectBuildBatchConfig,

    /// The number of the batch build. For each project, the `buildBatchNumber` of
    /// its
    /// first batch build is `1`. The `buildBatchNumber` of each subsequent
    /// batch build is incremented by `1`. If a batch build is deleted, the
    /// `buildBatchNumber` of other batch builds does not change.
    build_batch_number: ?i64,

    /// The status of the batch build.
    build_batch_status: ?StatusType,

    /// An array of `BuildGroup` objects that define the build groups for the
    /// batch build.
    build_groups: ?[]const BuildGroup,

    /// Specifies the maximum amount of time, in minutes, that the build in a batch
    /// must be
    /// completed in.
    build_timeout_in_minutes: ?i32,

    cache: ?ProjectCache,

    /// Indicates if the batch build is complete.
    complete: bool = false,

    /// The current phase of the batch build.
    current_phase: ?[]const u8,

    /// Specifies if session debugging is enabled for this batch build. For more
    /// information, see
    /// [Viewing a running build in Session
    /// Manager](https://docs.aws.amazon.com/codebuild/latest/userguide/session-manager.html). Batch session debugging is not supported for matrix batch builds.
    debug_session_enabled: ?bool,

    /// The Key Management Service customer master key (CMK) to be used for
    /// encrypting the batch build output
    /// artifacts.
    ///
    /// You can use a cross-account KMS key to encrypt the build output artifacts if
    /// your
    /// service role has permission to that key.
    ///
    /// You can specify either the Amazon Resource Name (ARN) of the CMK or, if
    /// available, the CMK's alias (using
    /// the format `alias/`).
    encryption_key: ?[]const u8,

    /// The date and time that the batch build ended.
    end_time: ?i64,

    environment: ?ProjectEnvironment,

    /// An array of `ProjectFileSystemLocation` objects for the batch build
    /// project. A `ProjectFileSystemLocation` object specifies the
    /// `identifier`, `location`, `mountOptions`,
    /// `mountPoint`, and `type` of a file system created using Amazon
    /// Elastic File System.
    file_system_locations: ?[]const ProjectFileSystemLocation,

    /// The identifier of the batch build.
    id: ?[]const u8,

    /// The entity that started the batch build. Valid values include:
    ///
    /// * If CodePipeline started the build, the pipeline's name (for example,
    /// `codepipeline/my-demo-pipeline`).
    ///
    /// * If a user started the build, the user's name.
    ///
    /// * If the Jenkins plugin for CodeBuild started the build, the string
    /// `CodeBuild-Jenkins-Plugin`.
    initiator: ?[]const u8,

    log_config: ?LogsConfig,

    /// An array of `BuildBatchPhase` objects the specify the phases of the
    /// batch build.
    phases: ?[]const BuildBatchPhase,

    /// The name of the batch build project.
    project_name: ?[]const u8,

    /// Specifies the amount of time, in minutes, that the batch build is allowed to
    /// be queued
    /// before it times out.
    queued_timeout_in_minutes: ?i32,

    /// An array that contains the ARNs of reports created by merging reports from
    /// builds associated with this batch build.
    report_arns: ?[]const []const u8,

    /// The identifier of the resolved version of this batch build's source code.
    ///
    /// * For CodeCommit, GitHub, GitHub Enterprise, and BitBucket, the commit ID.
    ///
    /// * For CodePipeline, the source revision provided by CodePipeline.
    ///
    /// * For Amazon S3, this does not apply.
    resolved_source_version: ?[]const u8,

    /// An array of `BuildArtifacts` objects the define the build artifacts
    /// for this batch build.
    secondary_artifacts: ?[]const BuildArtifacts,

    /// An array of `ProjectSource` objects that define the sources for the batch
    /// build.
    secondary_sources: ?[]const ProjectSource,

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
    secondary_source_versions: ?[]const ProjectSourceVersion,

    /// The name of a service role used for builds in the batch.
    service_role: ?[]const u8,

    source: ?ProjectSource,

    /// The identifier of the version of the source code to be built.
    source_version: ?[]const u8,

    /// The date and time that the batch build started.
    start_time: ?i64,

    vpc_config: ?VpcConfig,

    pub const json_field_names = .{
        .arn = "arn",
        .artifacts = "artifacts",
        .build_batch_config = "buildBatchConfig",
        .build_batch_number = "buildBatchNumber",
        .build_batch_status = "buildBatchStatus",
        .build_groups = "buildGroups",
        .build_timeout_in_minutes = "buildTimeoutInMinutes",
        .cache = "cache",
        .complete = "complete",
        .current_phase = "currentPhase",
        .debug_session_enabled = "debugSessionEnabled",
        .encryption_key = "encryptionKey",
        .end_time = "endTime",
        .environment = "environment",
        .file_system_locations = "fileSystemLocations",
        .id = "id",
        .initiator = "initiator",
        .log_config = "logConfig",
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
        .vpc_config = "vpcConfig",
    };
};
