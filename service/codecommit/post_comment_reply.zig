const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Comment = @import("comment.zig").Comment;

pub const PostCommentReplyInput = struct {
    /// A unique, client-generated idempotency token that, when provided in a
    /// request, ensures
    /// the request cannot be repeated with a changed parameter. If a request is
    /// received with
    /// the same parameters and a token is included, the request returns information
    /// about the
    /// initial request that used that token.
    client_request_token: ?[]const u8 = null,

    /// The contents of your reply to a comment.
    content: []const u8,

    /// The system-generated ID of the comment to which you want to reply. To get
    /// this ID, use GetCommentsForComparedCommit
    /// or GetCommentsForPullRequest.
    in_reply_to: []const u8,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .content = "content",
        .in_reply_to = "inReplyTo",
    };
};

pub const PostCommentReplyOutput = struct {
    /// Information about the reply to a comment.
    comment: ?Comment = null,

    pub const json_field_names = .{
        .comment = "comment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PostCommentReplyInput, options: CallOptions) !PostCommentReplyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PostCommentReplyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.PostCommentReply");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PostCommentReplyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PostCommentReplyOutput, body, allocator);
}
