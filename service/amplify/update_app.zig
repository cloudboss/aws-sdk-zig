const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AutoBranchCreationConfig = @import("auto_branch_creation_config.zig").AutoBranchCreationConfig;
const CacheConfig = @import("cache_config.zig").CacheConfig;
const CustomRule = @import("custom_rule.zig").CustomRule;
const JobConfig = @import("job_config.zig").JobConfig;
const Platform = @import("platform.zig").Platform;
const App = @import("app.zig").App;

pub const UpdateAppInput = struct {
    /// The personal access token for a GitHub repository for an Amplify app. The
    /// personal
    /// access token is used to authorize access to a GitHub repository using the
    /// Amplify GitHub
    /// App. The token is not stored.
    ///
    /// Use `accessToken` for GitHub repositories only. To authorize access to a
    /// repository provider such as Bitbucket or CodeCommit, use `oauthToken`.
    ///
    /// You must specify either `accessToken` or `oauthToken` when you
    /// update an app.
    ///
    /// Existing Amplify apps deployed from a GitHub repository using OAuth continue
    /// to work
    /// with CI/CD. However, we strongly recommend that you migrate these apps to
    /// use the GitHub
    /// App. For more information, see [Migrating an existing OAuth app to the
    /// Amplify GitHub
    /// App](https://docs.aws.amazon.com/amplify/latest/userguide/setting-up-GitHub-access.html#migrating-to-github-app-auth) in the
    /// *Amplify User Guide* .
    access_token: ?[]const u8 = null,

    /// The unique ID for an Amplify app.
    app_id: []const u8,

    /// The automated branch creation configuration for an Amplify app.
    auto_branch_creation_config: ?AutoBranchCreationConfig = null,

    /// Describes the automated branch creation glob patterns for an Amplify app.
    auto_branch_creation_patterns: ?[]const []const u8 = null,

    /// The basic authorization credentials for an Amplify app. You must
    /// base64-encode the
    /// authorization credentials and provide them in the format
    /// `user:password`.
    basic_auth_credentials: ?[]const u8 = null,

    /// The build specification (build spec) for an Amplify app.
    build_spec: ?[]const u8 = null,

    /// The cache configuration for the Amplify app.
    cache_config: ?CacheConfig = null,

    /// The Amazon Resource Name (ARN) of the IAM role to assign to an SSR app.
    /// The SSR Compute role allows the Amplify Hosting compute service to
    /// securely access specific Amazon Web Services resources based on the role's
    /// permissions.
    /// For more information about the SSR Compute role, see [Adding an SSR Compute
    /// role](https://docs.aws.amazon.com/amplify/latest/userguide/amplify-SSR-compute-role.html) in the *Amplify User Guide*.
    compute_role_arn: ?[]const u8 = null,

    /// The custom HTTP headers for an Amplify app.
    custom_headers: ?[]const u8 = null,

    /// The custom redirect and rewrite rules for an Amplify app.
    custom_rules: ?[]const CustomRule = null,

    /// The description for an Amplify app.
    description: ?[]const u8 = null,

    /// Enables automated branch creation for an Amplify app.
    enable_auto_branch_creation: ?bool = null,

    /// Enables basic authorization for an Amplify app.
    enable_basic_auth: ?bool = null,

    /// Enables branch auto-building for an Amplify app.
    enable_branch_auto_build: ?bool = null,

    /// Automatically disconnects a branch in the Amplify console when you delete a
    /// branch
    /// from your Git repository.
    enable_branch_auto_deletion: ?bool = null,

    /// The environment variables for an Amplify app.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the IAM service role for the Amplify app.
    iam_service_role_arn: ?[]const u8 = null,

    /// Describes the configuration details that apply to the jobs for an Amplify
    /// app.
    job_config: ?JobConfig = null,

    /// The name for an Amplify app.
    name: ?[]const u8 = null,

    /// The OAuth token for a third-party source control system for an Amplify app.
    /// The OAuth
    /// token is used to create a webhook and a read-only deploy key using SSH
    /// cloning. The
    /// OAuth token is not stored.
    ///
    /// Use `oauthToken` for repository providers other than GitHub, such as
    /// Bitbucket or CodeCommit.
    ///
    /// To authorize access to GitHub as your repository provider, use
    /// `accessToken`.
    ///
    /// You must specify either `oauthToken` or `accessToken` when you
    /// update an app.
    ///
    /// Existing Amplify apps deployed from a GitHub repository using OAuth continue
    /// to work
    /// with CI/CD. However, we strongly recommend that you migrate these apps to
    /// use the GitHub
    /// App. For more information, see [Migrating an existing OAuth app to the
    /// Amplify GitHub
    /// App](https://docs.aws.amazon.com/amplify/latest/userguide/setting-up-GitHub-access.html#migrating-to-github-app-auth) in the
    /// *Amplify User Guide* .
    oauth_token: ?[]const u8 = null,

    /// The platform for the Amplify app. For a static app, set the platform type to
    /// `WEB`. For a dynamic server-side rendered (SSR) app, set the platform
    /// type to `WEB_COMPUTE`. For an app requiring Amplify Hosting's original SSR
    /// support only, set the platform type to `WEB_DYNAMIC`.
    ///
    /// If you are deploying an SSG only app with Next.js version 14 or later, you
    /// must set
    /// the platform type to `WEB_COMPUTE`.
    platform: ?Platform = null,

    /// The name of the Git repository for an Amplify app.
    repository: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .app_id = "appId",
        .auto_branch_creation_config = "autoBranchCreationConfig",
        .auto_branch_creation_patterns = "autoBranchCreationPatterns",
        .basic_auth_credentials = "basicAuthCredentials",
        .build_spec = "buildSpec",
        .cache_config = "cacheConfig",
        .compute_role_arn = "computeRoleArn",
        .custom_headers = "customHeaders",
        .custom_rules = "customRules",
        .description = "description",
        .enable_auto_branch_creation = "enableAutoBranchCreation",
        .enable_basic_auth = "enableBasicAuth",
        .enable_branch_auto_build = "enableBranchAutoBuild",
        .enable_branch_auto_deletion = "enableBranchAutoDeletion",
        .environment_variables = "environmentVariables",
        .iam_service_role_arn = "iamServiceRoleArn",
        .job_config = "jobConfig",
        .name = "name",
        .oauth_token = "oauthToken",
        .platform = "platform",
        .repository = "repository",
    };
};

pub const UpdateAppOutput = struct {
    /// Represents the updated Amplify app.
    app: ?App = null,

    pub const json_field_names = .{
        .app = "app",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAppInput, options: Options) !UpdateAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "amplify");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplify", "Amplify", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/apps/");
    try path_buf.appendSlice(alloc, input.app_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.access_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"accessToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.auto_branch_creation_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"autoBranchCreationConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.auto_branch_creation_patterns) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"autoBranchCreationPatterns\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.basic_auth_credentials) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"basicAuthCredentials\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.build_spec) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"buildSpec\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.cache_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"cacheConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.compute_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"computeRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.custom_headers) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"customHeaders\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.custom_rules) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"customRules\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enable_auto_branch_creation) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"enableAutoBranchCreation\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enable_basic_auth) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"enableBasicAuth\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enable_branch_auto_build) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"enableBranchAutoBuild\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enable_branch_auto_deletion) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"enableBranchAutoDeletion\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.environment_variables) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"environmentVariables\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.iam_service_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"iamServiceRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.job_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"jobConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.oauth_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"oauthToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.platform) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"platform\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.repository) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"repository\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateAppOutput {
    var result: UpdateAppOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAppOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependentServiceFailureException")) {
        return .{ .arena = arena, .kind = .{ .dependent_service_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
