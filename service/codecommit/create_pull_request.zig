const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Target = @import("target.zig").Target;
const PullRequest = @import("pull_request.zig").PullRequest;

pub const CreatePullRequestInput = struct {
    /// A unique, client-generated idempotency token that, when provided in a
    /// request, ensures
    /// the request cannot be repeated with a changed parameter. If a request is
    /// received with
    /// the same parameters and a token is included, the request returns information
    /// about the
    /// initial request that used that token.
    ///
    /// The Amazon Web ServicesSDKs prepopulate client request tokens. If you are
    /// using an Amazon Web ServicesSDK, an
    /// idempotency token is created for you.
    client_request_token: ?[]const u8 = null,

    /// A description of the pull request.
    description: ?[]const u8 = null,

    /// The targets for the pull request, including the source of the code to be
    /// reviewed (the
    /// source branch) and the destination where the creator of the pull request
    /// intends the
    /// code to be merged after the pull request is closed (the destination branch).
    targets: []const Target,

    /// The title of the pull request. This title is used to identify the pull
    /// request to
    /// other users in the repository.
    title: []const u8,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .description = "description",
        .targets = "targets",
        .title = "title",
    };
};

pub const CreatePullRequestOutput = struct {
    /// Information about the newly created pull request.
    pull_request: ?PullRequest = null,

    pub const json_field_names = .{
        .pull_request = "pullRequest",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePullRequestInput, options: CallOptions) !CreatePullRequestOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecommit", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePullRequestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecommit", "CodeCommit", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.CreatePullRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePullRequestOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreatePullRequestOutput, body, allocator);
}
