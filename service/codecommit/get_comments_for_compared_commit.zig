const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommentsForComparedCommit = @import("comments_for_compared_commit.zig").CommentsForComparedCommit;

pub const GetCommentsForComparedCommitInput = struct {
    /// To establish the directionality of the comparison, the full commit ID of the
    /// after
    /// commit.
    after_commit_id: []const u8,

    /// To establish the directionality of the comparison, the full commit ID of the
    /// before
    /// commit.
    before_commit_id: ?[]const u8 = null,

    /// A non-zero, non-negative integer used to limit the number of returned
    /// results. The
    /// default is 100 comments, but you can configure up to 500.
    max_results: ?i32 = null,

    /// An enumeration token that when provided in a request, returns the next batch
    /// of the results.
    next_token: ?[]const u8 = null,

    /// The name of the repository where you want to compare commits.
    repository_name: []const u8,

    pub const json_field_names = .{
        .after_commit_id = "afterCommitId",
        .before_commit_id = "beforeCommitId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .repository_name = "repositoryName",
    };
};

pub const GetCommentsForComparedCommitOutput = struct {
    /// A list of comment objects on the compared commit.
    comments_for_compared_commit_data: ?[]const CommentsForComparedCommit = null,

    /// An enumeration token that can be used in a request to return the next batch
    /// of the results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .comments_for_compared_commit_data = "commentsForComparedCommitData",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCommentsForComparedCommitInput, options: CallOptions) !GetCommentsForComparedCommitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCommentsForComparedCommitInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.GetCommentsForComparedCommit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCommentsForComparedCommitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCommentsForComparedCommitOutput, body, allocator);
}
