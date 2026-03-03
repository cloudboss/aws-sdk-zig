const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const WebhookBuildType = @import("webhook_build_type.zig").WebhookBuildType;
const WebhookFilter = @import("webhook_filter.zig").WebhookFilter;
const PullRequestBuildPolicy = @import("pull_request_build_policy.zig").PullRequestBuildPolicy;
const Webhook = @import("webhook.zig").Webhook;

pub const UpdateWebhookInput = struct {
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

    /// An array of arrays of `WebhookFilter` objects used to determine if a
    /// webhook event can trigger a build. A filter group must contain at least one
    /// `EVENT`
    /// `WebhookFilter`.
    filter_groups: ?[]const []const WebhookFilter = null,

    /// The name of the CodeBuild project.
    project_name: []const u8,

    /// A PullRequestBuildPolicy object that defines comment-based approval
    /// requirements for triggering builds on pull requests. This policy helps
    /// control when automated builds are executed based on contributor permissions
    /// and approval workflows.
    pull_request_build_policy: ?PullRequestBuildPolicy = null,

    /// A boolean value that specifies whether the associated GitHub repository's
    /// secret
    /// token should be updated. If you use Bitbucket for your repository,
    /// `rotateSecret` is ignored.
    rotate_secret: ?bool = null,

    pub const json_field_names = .{
        .branch_filter = "branchFilter",
        .build_type = "buildType",
        .filter_groups = "filterGroups",
        .project_name = "projectName",
        .pull_request_build_policy = "pullRequestBuildPolicy",
        .rotate_secret = "rotateSecret",
    };
};

pub const UpdateWebhookOutput = struct {
    /// Information about a repository's webhook that is associated with a project
    /// in CodeBuild.
    webhook: ?Webhook = null,

    pub const json_field_names = .{
        .webhook = "webhook",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWebhookInput, options: Options) !UpdateWebhookOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWebhookInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.UpdateWebhook");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWebhookOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateWebhookOutput, body, allocator);
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
