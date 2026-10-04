const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Location = @import("location.zig").Location;
const Comment = @import("comment.zig").Comment;

pub const PostCommentForComparedCommitInput = struct {
    /// To establish the directionality of the comparison, the full commit ID of the
    /// after
    /// commit.
    after_commit_id: []const u8,

    /// To establish the directionality of the comparison, the full commit ID of the
    /// before
    /// commit. Required for commenting on any commit unless that commit is the
    /// initial
    /// commit.
    before_commit_id: ?[]const u8 = null,

    /// A unique, client-generated idempotency token that, when provided in a
    /// request, ensures
    /// the request cannot be repeated with a changed parameter. If a request is
    /// received with
    /// the same parameters and a token is included, the request returns information
    /// about the
    /// initial request that used that token.
    client_request_token: ?[]const u8 = null,

    /// The content of the comment you want to make.
    content: []const u8,

    /// The location of the comparison where you want to comment.
    location: ?Location = null,

    /// The name of the repository where you want to post a comment on the
    /// comparison between commits.
    repository_name: []const u8,

    pub const json_field_names = .{
        .after_commit_id = "afterCommitId",
        .before_commit_id = "beforeCommitId",
        .client_request_token = "clientRequestToken",
        .content = "content",
        .location = "location",
        .repository_name = "repositoryName",
    };
};

pub const PostCommentForComparedCommitOutput = struct {
    /// In the directionality you established, the blob ID of the after blob.
    after_blob_id: ?[]const u8 = null,

    /// In the directionality you established, the full commit ID of the after
    /// commit.
    after_commit_id: ?[]const u8 = null,

    /// In the directionality you established, the blob ID of the before blob.
    before_blob_id: ?[]const u8 = null,

    /// In the directionality you established, the full commit ID of the before
    /// commit.
    before_commit_id: ?[]const u8 = null,

    /// The content of the comment you posted.
    comment: ?Comment = null,

    /// The location of the comment in the comparison between the two commits.
    location: ?Location = null,

    /// The name of the repository where you posted a comment on the comparison
    /// between commits.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_blob_id = "afterBlobId",
        .after_commit_id = "afterCommitId",
        .before_blob_id = "beforeBlobId",
        .before_commit_id = "beforeCommitId",
        .comment = "comment",
        .location = "location",
        .repository_name = "repositoryName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PostCommentForComparedCommitInput, options: CallOptions) !PostCommentForComparedCommitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PostCommentForComparedCommitInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.PostCommentForComparedCommit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PostCommentForComparedCommitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PostCommentForComparedCommitOutput, body, allocator);
}
