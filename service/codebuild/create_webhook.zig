const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const WebhookBuildType = @import("webhook_build_type.zig").WebhookBuildType;
const WebhookFilter = @import("webhook_filter.zig").WebhookFilter;
const PullRequestBuildPolicy = @import("pull_request_build_policy.zig").PullRequestBuildPolicy;
const ScopeConfiguration = @import("scope_configuration.zig").ScopeConfiguration;
const Webhook = @import("webhook.zig").Webhook;

pub const CreateWebhookInput = struct {
    /// A regular expression used to determine which repository branches are built
    /// when a
    /// webhook is triggered. If the name of a branch matches the regular
    /// expression, then it is
    /// built. If `branchFilter` is empty, then all branches are built.
    ///
    /// It is recommended that you use `filterGroups` instead of
    /// `branchFilter`.
    branch_filter: ?[]const u8 = null,

    /// Specifies the type of build this webhook will trigger.
    ///
    /// `RUNNER_BUILDKITE_BUILD` is only available for `NO_SOURCE` source type
    /// projects
    /// configured for Buildkite runner builds. For more information about
    /// CodeBuild-hosted Buildkite runner builds, see [Tutorial: Configure a
    /// CodeBuild-hosted Buildkite
    /// runner](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-runner-buildkite.html) in the *CodeBuild
    /// user guide*.
    build_type: ?WebhookBuildType = null,

    /// An array of arrays of `WebhookFilter` objects used to determine which
    /// webhooks are triggered. At least one `WebhookFilter` in the array must
    /// specify `EVENT` as its `type`.
    ///
    /// For a build to be triggered, at least one filter group in the
    /// `filterGroups` array must pass. For a filter group to pass, each of its
    /// filters must pass.
    filter_groups: ?[]const []const WebhookFilter = null,

    /// If manualCreation is true, CodeBuild doesn't create a webhook in GitHub and
    /// instead returns `payloadUrl` and
    /// `secret` values for the webhook. The `payloadUrl` and `secret` values in the
    /// output can be
    /// used to manually create a webhook within GitHub.
    ///
    /// `manualCreation` is only available for GitHub webhooks.
    manual_creation: ?bool = null,

    /// The name of the CodeBuild project.
    project_name: []const u8,

    /// A PullRequestBuildPolicy object that defines comment-based approval
    /// requirements for triggering builds on pull requests. This policy helps
    /// control when automated builds are executed based on contributor permissions
    /// and approval workflows.
    pull_request_build_policy: ?PullRequestBuildPolicy = null,

    /// The scope configuration for global or organization webhooks.
    ///
    /// Global or organization webhooks are only available for GitHub and Github
    /// Enterprise webhooks.
    scope_configuration: ?ScopeConfiguration = null,

    pub const json_field_names = .{
        .branch_filter = "branchFilter",
        .build_type = "buildType",
        .filter_groups = "filterGroups",
        .manual_creation = "manualCreation",
        .project_name = "projectName",
        .pull_request_build_policy = "pullRequestBuildPolicy",
        .scope_configuration = "scopeConfiguration",
    };
};

pub const CreateWebhookOutput = struct {
    /// Information about a webhook that connects repository events to a build
    /// project in
    /// CodeBuild.
    webhook: ?Webhook = null,

    pub const json_field_names = .{
        .webhook = "webhook",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWebhookInput, options: Options) !CreateWebhookOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateWebhookInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "CodeBuild_20161006.CreateWebhook");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateWebhookOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateWebhookOutput, body, alloc);
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
