const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Location = @import("location.zig").Location;
const Comment = @import("comment.zig").Comment;

pub const PostCommentForPullRequestInput = struct {
    /// The full commit ID of the commit in the source branch that is the current
    /// tip of the branch for the pull request when you post the comment.
    after_commit_id: []const u8,

    /// The full commit ID of the commit in the destination branch that was the tip
    /// of the branch at the time the pull request was created.
    before_commit_id: []const u8,

    /// A unique, client-generated idempotency token that, when provided in a
    /// request, ensures
    /// the request cannot be repeated with a changed parameter. If a request is
    /// received with
    /// the same parameters and a token is included, the request returns information
    /// about the
    /// initial request that used that token.
    client_request_token: ?[]const u8 = null,

    /// The content of your comment on the change.
    content: []const u8,

    /// The location of the change where you want to post your comment. If no
    /// location is
    /// provided, the comment is posted as a general comment on the pull request
    /// difference
    /// between the before commit ID and the after commit ID.
    location: ?Location = null,

    /// The system-generated ID of the pull request. To get this ID, use
    /// ListPullRequests.
    pull_request_id: []const u8,

    /// The name of the repository where you want to post a comment on a pull
    /// request.
    repository_name: []const u8,

    pub const json_field_names = .{
        .after_commit_id = "afterCommitId",
        .before_commit_id = "beforeCommitId",
        .client_request_token = "clientRequestToken",
        .content = "content",
        .location = "location",
        .pull_request_id = "pullRequestId",
        .repository_name = "repositoryName",
    };
};

pub const PostCommentForPullRequestOutput = struct {
    /// In the directionality of the pull request, the blob ID of the after blob.
    after_blob_id: ?[]const u8 = null,

    /// The full commit ID of the commit in the destination branch where the pull
    /// request is
    /// merged.
    after_commit_id: ?[]const u8 = null,

    /// In the directionality of the pull request, the blob ID of the before blob.
    before_blob_id: ?[]const u8 = null,

    /// The full commit ID of the commit in the source branch used to create the
    /// pull request,
    /// or in the case of an updated pull request, the full commit ID of the commit
    /// used to update the pull request.
    before_commit_id: ?[]const u8 = null,

    /// The content of the comment you posted.
    comment: ?Comment = null,

    /// The location of the change where you posted your comment.
    location: ?Location = null,

    /// The system-generated ID of the pull request.
    pull_request_id: ?[]const u8 = null,

    /// The name of the repository where you posted a comment on a pull request.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_blob_id = "afterBlobId",
        .after_commit_id = "afterCommitId",
        .before_blob_id = "beforeBlobId",
        .before_commit_id = "beforeCommitId",
        .comment = "comment",
        .location = "location",
        .pull_request_id = "pullRequestId",
        .repository_name = "repositoryName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PostCommentForPullRequestInput, options: CallOptions) !PostCommentForPullRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PostCommentForPullRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.PostCommentForPullRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PostCommentForPullRequestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PostCommentForPullRequestOutput, body, allocator);
}
