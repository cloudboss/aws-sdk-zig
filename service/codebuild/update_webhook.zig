const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWebhookInput, options: CallOptions) !UpdateWebhookOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codebuild", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWebhookInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
