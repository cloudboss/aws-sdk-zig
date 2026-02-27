const SandboxSession = @import("sandbox_session.zig").SandboxSession;
const ProjectEnvironment = @import("project_environment.zig").ProjectEnvironment;
const ProjectFileSystemLocation = @import("project_file_system_location.zig").ProjectFileSystemLocation;
const LogsConfig = @import("logs_config.zig").LogsConfig;
const ProjectSource = @import("project_source.zig").ProjectSource;
const ProjectSourceVersion = @import("project_source_version.zig").ProjectSourceVersion;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Contains sandbox information.
pub const Sandbox = struct {
    /// The ARN of the sandbox.
    arn: ?[]const u8,

    /// The current session for the sandbox.
    current_session: ?SandboxSession,

    /// The Key Management Service customer master key (CMK) to be used for
    /// encrypting the sandbox output
    /// artifacts.
    encryption_key: ?[]const u8,

    /// When the sandbox process ended, expressed in Unix time format.
    end_time: ?i64,

    environment: ?ProjectEnvironment,

    /// An array of `ProjectFileSystemLocation` objects for a CodeBuild build
    /// project. A `ProjectFileSystemLocation` object
    /// specifies the `identifier`, `location`, `mountOptions`,
    /// `mountPoint`, and `type` of a file system created using Amazon Elastic File
    /// System.
    file_system_locations: ?[]const ProjectFileSystemLocation,

    /// The ID of the sandbox.
    id: ?[]const u8,

    log_config: ?LogsConfig,

    /// The CodeBuild project name.
    project_name: ?[]const u8,

    /// The number of minutes a sandbox is allowed to be queued before it times out.
    queued_timeout_in_minutes: ?i32,

    /// When the sandbox process was initially requested, expressed in Unix time
    /// format.
    request_time: ?i64,

    /// An array of `ProjectSource` objects.
    secondary_sources: ?[]const ProjectSource,

    /// An array of `ProjectSourceVersion` objects.
    secondary_source_versions: ?[]const ProjectSourceVersion,

    /// The name of a service role used for this sandbox.
    service_role: ?[]const u8,

    source: ?ProjectSource,

    /// Any version identifier for the version of the sandbox to be built.
    source_version: ?[]const u8,

    /// When the sandbox process started, expressed in Unix time format.
    start_time: ?i64,

    /// The status of the sandbox.
    status: ?[]const u8,

    /// How long, in minutes, from 5 to 2160 (36 hours), for CodeBuild to wait
    /// before timing out this sandbox if it does not
    /// get marked as completed.
    timeout_in_minutes: ?i32,

    vpc_config: ?VpcConfig,

    pub const json_field_names = .{
        .arn = "arn",
        .current_session = "currentSession",
        .encryption_key = "encryptionKey",
        .end_time = "endTime",
        .environment = "environment",
        .file_system_locations = "fileSystemLocations",
        .id = "id",
        .log_config = "logConfig",
        .project_name = "projectName",
        .queued_timeout_in_minutes = "queuedTimeoutInMinutes",
        .request_time = "requestTime",
        .secondary_sources = "secondarySources",
        .secondary_source_versions = "secondarySourceVersions",
        .service_role = "serviceRole",
        .source = "source",
        .source_version = "sourceVersion",
        .start_time = "startTime",
        .status = "status",
        .timeout_in_minutes = "timeoutInMinutes",
        .vpc_config = "vpcConfig",
    };
};
