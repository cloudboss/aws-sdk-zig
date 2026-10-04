const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReactionForComment = @import("reaction_for_comment.zig").ReactionForComment;

pub const GetCommentReactionsInput = struct {
    /// The ID of the comment for which you want to get reactions information.
    comment_id: []const u8,

    /// A non-zero, non-negative integer used to limit the number of returned
    /// results. The default is the same as the allowed maximum, 1,000.
    max_results: ?i32 = null,

    /// An enumeration token that, when provided in a request, returns the next
    /// batch of the results.
    next_token: ?[]const u8 = null,

    /// Optional. The Amazon Resource Name (ARN) of the user or identity for which
    /// you want to get reaction information.
    reaction_user_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .comment_id = "commentId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .reaction_user_arn = "reactionUserArn",
    };
};

pub const GetCommentReactionsOutput = struct {
    /// An enumeration token that can be used in a request to return the next batch
    /// of the results.
    next_token: ?[]const u8 = null,

    /// An array of reactions to the specified comment.
    reactions_for_comment: ?[]const ReactionForComment = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .reactions_for_comment = "reactionsForComment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCommentReactionsInput, options: CallOptions) !GetCommentReactionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCommentReactionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.GetCommentReactions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCommentReactionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetCommentReactionsOutput, body, allocator);
}
