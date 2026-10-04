const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PullRequest = @import("pull_request.zig").PullRequest;

pub const MergePullRequestByFastForwardInput = struct {
    /// The system-generated ID of the pull request. To get this ID, use
    /// ListPullRequests.
    pull_request_id: []const u8,

    /// The name of the repository where the pull request was created.
    repository_name: []const u8,

    /// The full commit ID of the original or updated commit in the pull request
    /// source branch. Pass this value if you want an
    /// exception thrown if the current commit ID of the tip of the source branch
    /// does not match this commit ID.
    source_commit_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .pull_request_id = "pullRequestId",
        .repository_name = "repositoryName",
        .source_commit_id = "sourceCommitId",
    };
};

pub const MergePullRequestByFastForwardOutput = struct {
    /// Information about the specified pull request, including the merge.
    pull_request: ?PullRequest = null,

    pub const json_field_names = .{
        .pull_request = "pullRequest",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: MergePullRequestByFastForwardInput, options: CallOptions) !MergePullRequestByFastForwardOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: MergePullRequestByFastForwardInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.MergePullRequestByFastForward");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !MergePullRequestByFastForwardOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(MergePullRequestByFastForwardOutput, body, allocator);
}
