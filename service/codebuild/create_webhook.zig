const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWebhookInput, options: CallOptions) !CreateWebhookOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWebhookInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.CreateWebhook");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWebhookOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateWebhookOutput, body, allocator);
}
