const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ProjectArtifacts = @import("project_artifacts.zig").ProjectArtifacts;
const BuildStatusConfig = @import("build_status_config.zig").BuildStatusConfig;
const ProjectCache = @import("project_cache.zig").ProjectCache;
const ComputeType = @import("compute_type.zig").ComputeType;
const EnvironmentType = @import("environment_type.zig").EnvironmentType;
const EnvironmentVariable = @import("environment_variable.zig").EnvironmentVariable;
const ProjectFleet = @import("project_fleet.zig").ProjectFleet;
const GitSubmodulesConfig = @import("git_submodules_config.zig").GitSubmodulesConfig;
const ImagePullCredentialsType = @import("image_pull_credentials_type.zig").ImagePullCredentialsType;
const LogsConfig = @import("logs_config.zig").LogsConfig;
const RegistryCredential = @import("registry_credential.zig").RegistryCredential;
const ProjectSource = @import("project_source.zig").ProjectSource;
const ProjectSourceVersion = @import("project_source_version.zig").ProjectSourceVersion;
const SourceAuth = @import("source_auth.zig").SourceAuth;
const SourceType = @import("source_type.zig").SourceType;
const Build = @import("build.zig").Build;

pub const StartBuildInput = struct {
    /// Build output artifact settings that override, for this build only, the
    /// latest ones
    /// already defined in the build project.
    artifacts_override: ?ProjectArtifacts = null,

    /// The maximum number of additional automatic retries after a failed build. For
    /// example, if the
    /// auto-retry limit is set to 2, CodeBuild will call the `RetryBuild` API to
    /// automatically
    /// retry your build for up to 2 additional times.
    auto_retry_limit_override: ?i32 = null,

    /// A buildspec file declaration that overrides the latest one defined
    /// in the build project, for this build only. The buildspec defined on the
    /// project is not changed.
    ///
    /// If this value is set, it can be either an inline buildspec definition, the
    /// path to an
    /// alternate buildspec file relative to the value of the built-in
    /// `CODEBUILD_SRC_DIR` environment variable, or the path to an S3 bucket.
    /// The bucket must be in the same Amazon Web Services Region as the build
    /// project. Specify the buildspec
    /// file using its ARN (for example,
    /// `arn:aws:s3:::my-codebuild-sample2/buildspec.yml`). If this value is not
    /// provided or is set to an empty string, the source code must contain a
    /// buildspec file in
    /// its root directory. For more information, see [Buildspec File Name and
    /// Storage
    /// Location](https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html#build-spec-ref-name-storage).
    ///
    /// Since this property allows you to change the build commands that will run in
    /// the container,
    /// you should note that an IAM principal with the ability to call this API and
    /// set this parameter
    /// can override the default settings. Moreover, we encourage that you use a
    /// trustworthy buildspec location
    /// like a file in your source repository or a Amazon S3 bucket. Alternatively,
    /// you can restrict overrides
    /// to the buildspec by using a condition key: [Prevent unauthorized
    /// modifications to project
    /// buildspec](https://docs.aws.amazon.com/codebuild/latest/userguide/action-context-keys.html#action-context-keys-example-overridebuildspec.html).
    buildspec_override: ?[]const u8 = null,

    /// Contains information that defines how the build project reports the build
    /// status to
    /// the source provider. This option is only used when the source provider is
    /// `GITHUB`, `GITHUB_ENTERPRISE`, or
    /// `BITBUCKET`.
    build_status_config_override: ?BuildStatusConfig = null,

    /// A ProjectCache object specified for this build that overrides the one
    /// defined in the
    /// build project.
    cache_override: ?ProjectCache = null,

    /// The name of a certificate for this build that overrides the one specified in
    /// the build
    /// project.
    certificate_override: ?[]const u8 = null,

    /// The name of a compute type for this build that overrides the one specified
    /// in the
    /// build project.
    compute_type_override: ?ComputeType = null,

    /// Specifies if session debugging is enabled for this build. For more
    /// information, see
    /// [Viewing a running build in Session
    /// Manager](https://docs.aws.amazon.com/codebuild/latest/userguide/session-manager.html).
    debug_session_enabled: ?bool = null,

    /// The Key Management Service customer master key (CMK) that overrides the one
    /// specified in the build
    /// project. The CMK key encrypts the build output artifacts.
    ///
    /// You can use a cross-account KMS key to encrypt the build output artifacts if
    /// your
    /// service role has permission to that key.
    ///
    /// You can specify either the Amazon Resource Name (ARN) of the CMK or, if
    /// available, the CMK's alias (using
    /// the format `alias/`).
    encryption_key_override: ?[]const u8 = null,

    /// A container type for this build that overrides the one specified in the
    /// build
    /// project.
    environment_type_override: ?EnvironmentType = null,

    /// A set of environment variables that overrides, for this build only, the
    /// latest ones
    /// already defined in the build project.
    environment_variables_override: ?[]const EnvironmentVariable = null,

    /// A ProjectFleet object specified for this build that overrides the one
    /// defined in the
    /// build project.
    fleet_override: ?ProjectFleet = null,

    /// The user-defined depth of history, with a minimum value of 0, that
    /// overrides, for this
    /// build only, any previous depth of history defined in the build project.
    git_clone_depth_override: ?i32 = null,

    /// Information about the Git submodules configuration for this build of an
    /// CodeBuild build
    /// project.
    git_submodules_config_override: ?GitSubmodulesConfig = null,

    /// A unique, case sensitive identifier you provide to ensure the idempotency of
    /// the
    /// StartBuild request. The token is included in the StartBuild request and is
    /// valid for 5
    /// minutes. If you repeat the StartBuild request with the same token, but
    /// change a
    /// parameter, CodeBuild returns a parameter mismatch error.
    idempotency_token: ?[]const u8 = null,

    /// The name of an image for this build that overrides the one specified in the
    /// build
    /// project.
    image_override: ?[]const u8 = null,

    /// The type of credentials CodeBuild uses to pull images in your build. There
    /// are two valid
    /// values:
    ///
    /// **CODEBUILD**
    ///
    /// Specifies that CodeBuild uses its own credentials. This requires that you
    /// modify your ECR repository policy to trust CodeBuild's service principal.
    ///
    /// **SERVICE_ROLE**
    ///
    /// Specifies that CodeBuild uses your build project's service role.
    ///
    /// When using a cross-account or private registry image, you must use
    /// `SERVICE_ROLE` credentials. When using an CodeBuild curated image,
    /// you must use `CODEBUILD` credentials.
    image_pull_credentials_type_override: ?ImagePullCredentialsType = null,

    /// Enable this flag to override the insecure SSL setting that is specified in
    /// the build
    /// project. The insecure SSL setting determines whether to ignore SSL warnings
    /// while
    /// connecting to the project source code. This override applies only if the
    /// build's source
    /// is GitHub Enterprise.
    insecure_ssl_override: ?bool = null,

    /// Log settings for this build that override the log settings defined in the
    /// build
    /// project.
    logs_config_override: ?LogsConfig = null,

    /// Enable this flag to override privileged mode in the build project.
    privileged_mode_override: ?bool = null,

    /// The name of the CodeBuild build project to start running a build.
    project_name: []const u8,

    /// The number of minutes a build is allowed to be queued before it times out.
    queued_timeout_in_minutes_override: ?i32 = null,

    /// The credentials for access to a private registry.
    registry_credential_override: ?RegistryCredential = null,

    /// Set to true to report to your source provider the status of a build's start
    /// and
    /// completion. If you use this option with a source provider other than GitHub,
    /// GitHub
    /// Enterprise, GitLab, GitLab Self Managed, or Bitbucket, an
    /// `invalidInputException` is thrown.
    ///
    /// To be able to report the build status to the source provider, the user
    /// associated with the source provider must
    /// have write access to the repo. If the user does not have write access, the
    /// build status cannot be updated. For more information, see [Source provider
    /// access](https://docs.aws.amazon.com/codebuild/latest/userguide/access-tokens.html) in the *CodeBuild User Guide*.
    ///
    /// The status of a build triggered by a webhook is always reported to your
    /// source
    /// provider.
    report_build_status_override: ?bool = null,

    /// An array of `ProjectArtifacts` objects.
    secondary_artifacts_override: ?[]const ProjectArtifacts = null,

    /// An array of `ProjectSource` objects.
    secondary_sources_override: ?[]const ProjectSource = null,

    /// An array of `ProjectSourceVersion` objects that specify one or more
    /// versions of the project's secondary sources to be used for this build only.
    secondary_sources_version_override: ?[]const ProjectSourceVersion = null,

    /// The name of a service role for this build that overrides the one specified
    /// in the
    /// build project.
    service_role_override: ?[]const u8 = null,

    /// An authorization type for this build that overrides the one defined in the
    /// build
    /// project. This override applies only if the build project's source is
    /// BitBucket, GitHub,
    /// GitLab, or GitLab Self Managed.
    source_auth_override: ?SourceAuth = null,

    /// A location that overrides, for this build, the source location for the one
    /// defined in
    /// the build project.
    source_location_override: ?[]const u8 = null,

    /// A source input type, for this build, that overrides the source input defined
    /// in the
    /// build project.
    source_type_override: ?SourceType = null,

    /// The version of the build input to be built, for this build only. If not
    /// specified,
    /// the latest version is used. If specified, the contents depends on the source
    /// provider:
    ///
    /// **CodeCommit**
    ///
    /// The commit ID, branch, or Git tag to use.
    ///
    /// **GitHub**
    ///
    /// The commit ID, pull request ID, branch name, or tag name that corresponds
    /// to the version of the source code you want to build. If a pull request ID is
    /// specified, it must use the format `pr/pull-request-ID` (for
    /// example `pr/25`). If a branch name is specified, the branch's
    /// HEAD commit ID is used. If not specified, the default branch's HEAD commit
    /// ID is used.
    ///
    /// **GitLab**
    ///
    /// The commit ID, branch, or Git tag to use.
    ///
    /// **Bitbucket**
    ///
    /// The commit ID, branch name, or tag name that corresponds to the version of
    /// the source code you want to build. If a branch name is specified, the
    /// branch's HEAD commit ID is used. If not specified, the default branch's HEAD
    /// commit ID is used.
    ///
    /// **Amazon S3**
    ///
    /// The version ID of the object that represents the build input ZIP file to
    /// use.
    ///
    /// If `sourceVersion` is specified at the project level, then this
    /// `sourceVersion` (at the build level) takes precedence.
    ///
    /// For more information, see [Source Version Sample
    /// with
    /// CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-source-version.html) in the *CodeBuild User Guide*.
    source_version: ?[]const u8 = null,

    /// The number of build timeout minutes, from 5 to 2160 (36 hours), that
    /// overrides, for this
    /// build only, the latest setting already defined in the build project.
    timeout_in_minutes_override: ?i32 = null,

    pub const json_field_names = .{
        .artifacts_override = "artifactsOverride",
        .auto_retry_limit_override = "autoRetryLimitOverride",
        .buildspec_override = "buildspecOverride",
        .build_status_config_override = "buildStatusConfigOverride",
        .cache_override = "cacheOverride",
        .certificate_override = "certificateOverride",
        .compute_type_override = "computeTypeOverride",
        .debug_session_enabled = "debugSessionEnabled",
        .encryption_key_override = "encryptionKeyOverride",
        .environment_type_override = "environmentTypeOverride",
        .environment_variables_override = "environmentVariablesOverride",
        .fleet_override = "fleetOverride",
        .git_clone_depth_override = "gitCloneDepthOverride",
        .git_submodules_config_override = "gitSubmodulesConfigOverride",
        .idempotency_token = "idempotencyToken",
        .image_override = "imageOverride",
        .image_pull_credentials_type_override = "imagePullCredentialsTypeOverride",
        .insecure_ssl_override = "insecureSslOverride",
        .logs_config_override = "logsConfigOverride",
        .privileged_mode_override = "privilegedModeOverride",
        .project_name = "projectName",
        .queued_timeout_in_minutes_override = "queuedTimeoutInMinutesOverride",
        .registry_credential_override = "registryCredentialOverride",
        .report_build_status_override = "reportBuildStatusOverride",
        .secondary_artifacts_override = "secondaryArtifactsOverride",
        .secondary_sources_override = "secondarySourcesOverride",
        .secondary_sources_version_override = "secondarySourcesVersionOverride",
        .service_role_override = "serviceRoleOverride",
        .source_auth_override = "sourceAuthOverride",
        .source_location_override = "sourceLocationOverride",
        .source_type_override = "sourceTypeOverride",
        .source_version = "sourceVersion",
        .timeout_in_minutes_override = "timeoutInMinutesOverride",
    };
};

pub const StartBuildOutput = struct {
    /// Information about the build to be run.
    build: ?Build = null,

    pub const json_field_names = .{
        .build = "build",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartBuildInput, options: CallOptions) !StartBuildOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codebuild");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: StartBuildInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.StartBuild");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartBuildOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartBuildOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccountLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .account_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountSuspendedException")) {
        return .{ .arena = arena, .kind = .{ .account_suspended_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OAuthProviderException")) {
        return .{ .arena = arena, .kind = .{ .o_auth_provider_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
