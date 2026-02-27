const ProjectArtifacts = @import("project_artifacts.zig").ProjectArtifacts;
const ProjectBadge = @import("project_badge.zig").ProjectBadge;
const ProjectBuildBatchConfig = @import("project_build_batch_config.zig").ProjectBuildBatchConfig;
const ProjectCache = @import("project_cache.zig").ProjectCache;
const ProjectEnvironment = @import("project_environment.zig").ProjectEnvironment;
const ProjectFileSystemLocation = @import("project_file_system_location.zig").ProjectFileSystemLocation;
const LogsConfig = @import("logs_config.zig").LogsConfig;
const ProjectVisibilityType = @import("project_visibility_type.zig").ProjectVisibilityType;
const ProjectSource = @import("project_source.zig").ProjectSource;
const ProjectSourceVersion = @import("project_source_version.zig").ProjectSourceVersion;
const Tag = @import("tag.zig").Tag;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const Webhook = @import("webhook.zig").Webhook;

/// Information about a build project.
pub const Project = struct {
    /// The Amazon Resource Name (ARN) of the build project.
    arn: ?[]const u8,

    /// Information about the build output artifacts for the build project.
    artifacts: ?ProjectArtifacts,

    /// The maximum number of additional automatic retries after a failed build. For
    /// example, if the
    /// auto-retry limit is set to 2, CodeBuild will call the `RetryBuild` API to
    /// automatically
    /// retry your build for up to 2 additional times.
    auto_retry_limit: ?i32,

    /// Information about the build badge for the build project.
    badge: ?ProjectBadge,

    /// A ProjectBuildBatchConfig
    /// object that defines the batch build
    /// options for the project.
    build_batch_config: ?ProjectBuildBatchConfig,

    /// Information about the cache for the build project.
    cache: ?ProjectCache,

    /// The maximum number of concurrent builds that are allowed for this project.
    ///
    /// New builds are only started if the current number of builds is less than or
    /// equal to this limit.
    /// If the current build count meets this limit, new builds are throttled and
    /// are not run.
    concurrent_build_limit: ?i32,

    /// When the build project was created, expressed in Unix time format.
    created: ?i64,

    /// A description that makes the build project easy to identify.
    description: ?[]const u8,

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
    /// the format `alias/`). If you don't specify a
    /// value, CodeBuild uses the managed CMK for Amazon Simple Storage Service
    /// (Amazon S3).
    encryption_key: ?[]const u8,

    /// Information about the build environment for this build project.
    environment: ?ProjectEnvironment,

    /// An array of `ProjectFileSystemLocation` objects for a CodeBuild build
    /// project. A `ProjectFileSystemLocation` object
    /// specifies the `identifier`, `location`, `mountOptions`,
    /// `mountPoint`, and `type` of a file system created using Amazon Elastic File
    /// System.
    file_system_locations: ?[]const ProjectFileSystemLocation,

    /// When the build project's settings were last modified, expressed in Unix time
    /// format.
    last_modified: ?i64,

    /// Information about logs for the build project. A project can create logs in
    /// CloudWatch Logs, an
    /// S3 bucket, or both.
    logs_config: ?LogsConfig,

    /// The name of the build project.
    name: ?[]const u8,

    project_visibility: ?ProjectVisibilityType,

    /// Contains the project identifier used with the public build APIs.
    public_project_alias: ?[]const u8,

    /// The number of minutes a build is allowed to be queued before it times out.
    queued_timeout_in_minutes: ?i32,

    /// The ARN of the IAM role that enables CodeBuild to access the CloudWatch Logs
    /// and Amazon S3 artifacts for
    /// the project's builds.
    resource_access_role: ?[]const u8,

    /// An array of `ProjectArtifacts` objects.
    secondary_artifacts: ?[]const ProjectArtifacts,

    /// An array of `ProjectSource` objects.
    secondary_sources: ?[]const ProjectSource,

    /// An array of `ProjectSourceVersion` objects. If
    /// `secondarySourceVersions` is specified at the build level, then they take
    /// over these `secondarySourceVersions` (at the project level).
    secondary_source_versions: ?[]const ProjectSourceVersion,

    /// The ARN of the IAM role that enables CodeBuild to interact with dependent
    /// Amazon Web Services services
    /// on behalf of the Amazon Web Services account.
    service_role: ?[]const u8,

    /// Information about the build input source code for this build project.
    source: ?ProjectSource,

    /// A version of the build input to be built for this project. If not specified,
    /// the
    /// latest version is used. If specified, it must be one of:
    ///
    /// * For CodeCommit: the commit ID, branch, or Git tag to use.
    ///
    /// * For GitHub: the commit ID, pull request ID, branch name, or tag name that
    /// corresponds to the version of the source code you want to build. If a pull
    /// request ID is specified, it must use the format `pr/pull-request-ID`
    /// (for example `pr/25`). If a branch name is specified, the branch's
    /// HEAD commit ID is used. If not specified, the default branch's HEAD commit
    /// ID is
    /// used.
    ///
    /// * For GitLab: the commit ID, branch, or Git tag to use.
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
    ///
    /// If `sourceVersion` is specified at the build level, then that version
    /// takes precedence over this `sourceVersion` (at the project level).
    ///
    /// For more information, see [Source Version Sample
    /// with
    /// CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-source-version.html) in the *CodeBuild User Guide*.
    source_version: ?[]const u8,

    /// A list of tag key and value pairs associated with this build project.
    ///
    /// These tags are available for use by Amazon Web Services services that
    /// support CodeBuild build project
    /// tags.
    tags: ?[]const Tag,

    /// How long, in minutes, from 5 to 2160 (36 hours), for CodeBuild to wait
    /// before timing out any
    /// related build that did not get marked as completed. The default is 60
    /// minutes.
    timeout_in_minutes: ?i32,

    /// Information about the VPC configuration that CodeBuild accesses.
    vpc_config: ?VpcConfig,

    /// Information about a webhook that connects repository events to a build
    /// project in
    /// CodeBuild.
    webhook: ?Webhook,

    pub const json_field_names = .{
        .arn = "arn",
        .artifacts = "artifacts",
        .auto_retry_limit = "autoRetryLimit",
        .badge = "badge",
        .build_batch_config = "buildBatchConfig",
        .cache = "cache",
        .concurrent_build_limit = "concurrentBuildLimit",
        .created = "created",
        .description = "description",
        .encryption_key = "encryptionKey",
        .environment = "environment",
        .file_system_locations = "fileSystemLocations",
        .last_modified = "lastModified",
        .logs_config = "logsConfig",
        .name = "name",
        .project_visibility = "projectVisibility",
        .public_project_alias = "publicProjectAlias",
        .queued_timeout_in_minutes = "queuedTimeoutInMinutes",
        .resource_access_role = "resourceAccessRole",
        .secondary_artifacts = "secondaryArtifacts",
        .secondary_sources = "secondarySources",
        .secondary_source_versions = "secondarySourceVersions",
        .service_role = "serviceRole",
        .source = "source",
        .source_version = "sourceVersion",
        .tags = "tags",
        .timeout_in_minutes = "timeoutInMinutes",
        .vpc_config = "vpcConfig",
        .webhook = "webhook",
    };
};
