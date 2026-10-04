const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommentsForPullRequest = @import("comments_for_pull_request.zig").CommentsForPullRequest;

pub const GetCommentsForPullRequestInput = struct {
    /// The full commit ID of the commit in the source branch that was the tip of
    /// the branch at the time the comment was made. Requirement is conditional:
    /// `afterCommitId` must be specified when `repositoryName` is included.
    after_commit_id: ?[]const u8 = null,

    /// The full commit ID of the commit in the destination branch that was the tip
    /// of the branch at the time the pull request was created. Requirement is
    /// conditional:
    /// `beforeCommitId` must be specified when `repositoryName` is included.
    before_commit_id: ?[]const u8 = null,

    /// A non-zero, non-negative integer used to limit the number of returned
    /// results. The default is 100 comments.
    /// You can return up to 500 comments with a single request.
    max_results: ?i32 = null,

    /// An enumeration token that, when provided in a request, returns the next
    /// batch of the
    /// results.
    next_token: ?[]const u8 = null,

    /// The system-generated ID of the pull request. To get this ID, use
    /// ListPullRequests.
    pull_request_id: []const u8,

    /// The name of the repository that contains the pull request. Requirement is
    /// conditional: `repositoryName` must be specified when
    /// `beforeCommitId` and `afterCommitId` are included.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_commit_id = "afterCommitId",
        .before_commit_id = "beforeCommitId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .pull_request_id = "pullRequestId",
        .repository_name = "repositoryName",
    };
};

pub const GetCommentsForPullRequestOutput = struct {
    /// An array of comment objects on the pull request.
    comments_for_pull_request_data: ?[]const CommentsForPullRequest = null,

    /// An enumeration token that can be used in a request to return the next batch
    /// of the results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .comments_for_pull_request_data = "commentsForPullRequestData",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCommentsForPullRequestInput, options: CallOptions) !GetCommentsForPullRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCommentsForPullRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.GetCommentsForPullRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCommentsForPullRequestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCommentsForPullRequestOutput, body, allocator);
}
