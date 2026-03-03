const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ProjectArtifacts = @import("project_artifacts.zig").ProjectArtifacts;
const ProjectBuildBatchConfig = @import("project_build_batch_config.zig").ProjectBuildBatchConfig;
const ProjectCache = @import("project_cache.zig").ProjectCache;
const ProjectEnvironment = @import("project_environment.zig").ProjectEnvironment;
const ProjectFileSystemLocation = @import("project_file_system_location.zig").ProjectFileSystemLocation;
const LogsConfig = @import("logs_config.zig").LogsConfig;
const ProjectSource = @import("project_source.zig").ProjectSource;
const ProjectSourceVersion = @import("project_source_version.zig").ProjectSourceVersion;
const Tag = @import("tag.zig").Tag;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const Project = @import("project.zig").Project;

pub const CreateProjectInput = struct {
    /// Information about the build output artifacts for the build project.
    artifacts: ProjectArtifacts,

    /// The maximum number of additional automatic retries after a failed build. For
    /// example, if the
    /// auto-retry limit is set to 2, CodeBuild will call the `RetryBuild` API to
    /// automatically
    /// retry your build for up to 2 additional times.
    auto_retry_limit: ?i32 = null,

    /// Set this to true to generate a publicly accessible URL for your project's
    /// build
    /// badge.
    badge_enabled: ?bool = null,

    /// A ProjectBuildBatchConfig
    /// object that defines the batch build options
    /// for the project.
    build_batch_config: ?ProjectBuildBatchConfig = null,

    /// Stores recently used information so that it can be quickly accessed at a
    /// later
    /// time.
    cache: ?ProjectCache = null,

    /// The maximum number of concurrent builds that are allowed for this project.
    ///
    /// New builds are only started if the current number of builds is less than or
    /// equal to this limit.
    /// If the current build count meets this limit, new builds are throttled and
    /// are not run.
    concurrent_build_limit: ?i32 = null,

    /// A description that makes the build project easy to identify.
    description: ?[]const u8 = null,

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

    /// Information about the build environment for the build project.
    environment: ProjectEnvironment,

    /// An array of `ProjectFileSystemLocation` objects for a CodeBuild build
    /// project. A `ProjectFileSystemLocation` object
    /// specifies the `identifier`, `location`, `mountOptions`,
    /// `mountPoint`, and `type` of a file system created using Amazon Elastic File
    /// System.
    file_system_locations: ?[]const ProjectFileSystemLocation = null,

    /// Information about logs for the build project. These can be logs in
    /// CloudWatch Logs, logs
    /// uploaded to a specified S3 bucket, or both.
    logs_config: ?LogsConfig = null,

    /// The name of the build project.
    name: []const u8,

    /// The number of minutes a build is allowed to be queued before it times out.
    queued_timeout_in_minutes: ?i32 = null,

    /// An array of `ProjectArtifacts` objects.
    secondary_artifacts: ?[]const ProjectArtifacts = null,

    /// An array of `ProjectSource` objects.
    secondary_sources: ?[]const ProjectSource = null,

    /// An array of `ProjectSourceVersion` objects. If
    /// `secondarySourceVersions` is specified at the build level, then they take
    /// precedence over these `secondarySourceVersions` (at the project level).
    secondary_source_versions: ?[]const ProjectSourceVersion = null,

    /// The ARN of the IAM role that enables CodeBuild to interact with dependent
    /// Amazon Web Services services
    /// on behalf of the Amazon Web Services account.
    service_role: []const u8,

    /// Information about the build input source code for the build project.
    source: ProjectSource,

    /// A version of the build input to be built for this project. If not specified,
    /// the latest
    /// version is used. If specified, it must be one of:
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
    /// If `sourceVersion` is specified at the build level, then that version takes
    /// precedence over this `sourceVersion` (at the project level).
    ///
    /// For more information, see [Source Version Sample
    /// with
    /// CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-source-version.html) in the *CodeBuild User Guide*.
    source_version: ?[]const u8 = null,

    /// A list of tag key and value pairs associated with this build project.
    ///
    /// These tags are available for use by Amazon Web Services services that
    /// support CodeBuild build project
    /// tags.
    tags: ?[]const Tag = null,

    /// How long, in minutes, from 5 to 2160 (36 hours), for CodeBuild to wait
    /// before it times out
    /// any build that has not been marked as completed. The default is 60 minutes.
    timeout_in_minutes: ?i32 = null,

    /// VpcConfig enables CodeBuild to access resources in an Amazon VPC.
    ///
    /// If you're using compute fleets during project creation, do not provide
    /// vpcConfig.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .artifacts = "artifacts",
        .auto_retry_limit = "autoRetryLimit",
        .badge_enabled = "badgeEnabled",
        .build_batch_config = "buildBatchConfig",
        .cache = "cache",
        .concurrent_build_limit = "concurrentBuildLimit",
        .description = "description",
        .encryption_key = "encryptionKey",
        .environment = "environment",
        .file_system_locations = "fileSystemLocations",
        .logs_config = "logsConfig",
        .name = "name",
        .queued_timeout_in_minutes = "queuedTimeoutInMinutes",
        .secondary_artifacts = "secondaryArtifacts",
        .secondary_sources = "secondarySources",
        .secondary_source_versions = "secondarySourceVersions",
        .service_role = "serviceRole",
        .source = "source",
        .source_version = "sourceVersion",
        .tags = "tags",
        .timeout_in_minutes = "timeoutInMinutes",
        .vpc_config = "vpcConfig",
    };
};

pub const CreateProjectOutput = struct {
    /// Information about the build project that was created.
    project: ?Project = null,

    pub const json_field_names = .{
        .project = "project",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProjectInput, options: Options) !CreateProjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProjectInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.CreateProject");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProjectOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateProjectOutput, body, allocator);
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
