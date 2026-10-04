const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutCommentReactionInput = struct {
    /// The ID of the comment to which you want to add or update a reaction.
    comment_id: []const u8,

    /// The emoji reaction you want to add or update. To remove a reaction, provide
    /// a value of blank or null. You can also provide the value of none.
    /// For information about emoji reaction values supported in CodeCommit, see the
    /// [CodeCommit User
    /// Guide](https://docs.aws.amazon.com/codecommit/latest/userguide/how-to-commit-comment.html#emoji-reaction-table).
    reaction_value: []const u8,

    pub const json_field_names = .{
        .comment_id = "commentId",
        .reaction_value = "reactionValue",
    };
};

pub const PutCommentReactionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutCommentReactionInput, options: CallOptions) !PutCommentReactionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutCommentReactionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.PutCommentReaction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutCommentReactionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
