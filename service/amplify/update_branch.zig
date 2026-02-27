const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Backend = @import("backend.zig").Backend;
const Stage = @import("stage.zig").Stage;
const Branch = @import("branch.zig").Branch;

pub const UpdateBranchInput = struct {
    /// The unique ID for an Amplify app.
    app_id: []const u8,

    /// The backend for a `Branch` of an Amplify app. Use for a
    /// backend created from an CloudFormation stack.
    ///
    /// This field is available to Amplify Gen 2 apps only. When you deploy an
    /// application with Amplify Gen 2, you provision the app's backend
    /// infrastructure using
    /// Typescript code.
    backend: ?Backend = null,

    /// The Amazon Resource Name (ARN) for a backend environment that is part of a
    /// Gen 1
    /// Amplify app.
    ///
    /// This field is available to Amplify Gen 1 apps only where the backend is
    /// created using Amplify Studio or the Amplify command line
    /// interface (CLI).
    backend_environment_arn: ?[]const u8 = null,

    /// The basic authorization credentials for the branch. You must base64-encode
    /// the
    /// authorization credentials and provide them in the format
    /// `user:password`.
    basic_auth_credentials: ?[]const u8 = null,

    /// The name of the branch.
    branch_name: []const u8,

    /// The build specification (build spec) for the branch.
    build_spec: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role to assign to a branch of
    /// an SSR app. The SSR Compute role allows the Amplify Hosting compute
    /// service to securely access specific Amazon Web Services resources based on
    /// the role's
    /// permissions. For more information about the SSR Compute role, see [Adding an
    /// SSR Compute
    /// role](https://docs.aws.amazon.com/amplify/latest/userguide/amplify-SSR-compute-role.html) in the *Amplify User
    /// Guide*.
    compute_role_arn: ?[]const u8 = null,

    /// The description for the branch.
    description: ?[]const u8 = null,

    /// The display name for a branch. This is used as the default domain prefix.
    display_name: ?[]const u8 = null,

    /// Enables auto building for the branch.
    enable_auto_build: ?bool = null,

    /// Enables basic authorization for the branch.
    enable_basic_auth: ?bool = null,

    /// Enables notifications for the branch.
    enable_notification: ?bool = null,

    /// Enables performance mode for the branch.
    ///
    /// Performance mode optimizes for faster hosting performance by keeping content
    /// cached at
    /// the edge for a longer interval. When performance mode is enabled, hosting
    /// configuration
    /// or code changes can take up to 10 minutes to roll out.
    enable_performance_mode: ?bool = null,

    /// Enables pull request previews for this branch.
    enable_pull_request_preview: ?bool = null,

    /// Specifies whether the skew protection feature is enabled for the branch.
    ///
    /// Deployment skew protection is available to Amplify applications to
    /// eliminate version skew issues between client and servers in web
    /// applications. When you
    /// apply skew protection to a branch, you can ensure that your clients always
    /// interact with
    /// the correct version of server-side assets, regardless of when a deployment
    /// occurs. For
    /// more information about skew protection, see [Skew protection for Amplify
    /// deployments](https://docs.aws.amazon.com/amplify/latest/userguide/skew-protection.html) in the *Amplify User
    /// Guide*.
    enable_skew_protection: ?bool = null,

    /// The environment variables for the branch.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The framework for the branch.
    framework: ?[]const u8 = null,

    /// The Amplify environment name for the pull request.
    pull_request_environment_name: ?[]const u8 = null,

    /// Describes the current stage for the branch.
    stage: ?Stage = null,

    /// The content Time to Live (TTL) for the website in seconds.
    ttl: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .backend = "backend",
        .backend_environment_arn = "backendEnvironmentArn",
        .basic_auth_credentials = "basicAuthCredentials",
        .branch_name = "branchName",
        .build_spec = "buildSpec",
        .compute_role_arn = "computeRoleArn",
        .description = "description",
        .display_name = "displayName",
        .enable_auto_build = "enableAutoBuild",
        .enable_basic_auth = "enableBasicAuth",
        .enable_notification = "enableNotification",
        .enable_performance_mode = "enablePerformanceMode",
        .enable_pull_request_preview = "enablePullRequestPreview",
        .enable_skew_protection = "enableSkewProtection",
        .environment_variables = "environmentVariables",
        .framework = "framework",
        .pull_request_environment_name = "pullRequestEnvironmentName",
        .stage = "stage",
        .ttl = "ttl",
    };
};

pub const UpdateBranchOutput = struct {
    /// The branch for an Amplify app, which maps to a third-party repository
    /// branch.
    branch: ?Branch = null,

    pub const json_field_names = .{
        .branch = "branch",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBranchInput, options: Options) !UpdateBranchOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateBranchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplify", "Amplify", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/apps/");
    try path_buf.appendSlice(alloc, input.app_id);
    try path_buf.appendSlice(alloc, "/branches/");
    try path_buf.appendSlice(alloc, input.branch_name);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.backend) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"backend\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.backend_environment_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"backendEnvironmentArn\":");
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
    if (input.compute_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"computeRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enable_auto_build) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"enableAutoBuild\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enable_basic_auth) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"enableBasicAuth\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enable_notification) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"enableNotification\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enable_performance_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"enablePerformanceMode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enable_pull_request_preview) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"enablePullRequestPreview\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enable_skew_protection) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"enableSkewProtection\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.environment_variables) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"environmentVariables\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.framework) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"framework\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.pull_request_environment_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"pullRequestEnvironmentName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.stage) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"stage\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.ttl) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ttl\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateBranchOutput {
    var result: UpdateBranchOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateBranchOutput, body, alloc);
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
