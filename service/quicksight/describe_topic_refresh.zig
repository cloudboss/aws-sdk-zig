const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TopicRefreshDetails = @import("topic_refresh_details.zig").TopicRefreshDetails;

pub const DescribeTopicRefreshInput = struct {
    /// The ID of the Amazon Web Services account that contains the topic whose
    /// refresh you want
    /// to describe.
    aws_account_id: []const u8,

    /// The ID of the refresh, which is performed when the topic is created or
    /// updated.
    refresh_id: []const u8,

    /// The ID of the topic that you want to describe. This ID is unique per Amazon
    /// Web Services Region for each Amazon Web Services account.
    topic_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .refresh_id = "RefreshId",
        .topic_id = "TopicId",
    };
};

pub const DescribeTopicRefreshOutput = struct {
    /// Details of the refresh, which is performed when the topic is created or
    /// updated.
    refresh_details: ?TopicRefreshDetails = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .refresh_details = "RefreshDetails",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTopicRefreshInput, options: CallOptions) !DescribeTopicRefreshOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTopicRefreshInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/topics/");
    try path_buf.appendSlice(allocator, input.topic_id);
    try path_buf.appendSlice(allocator, "/refresh/");
    try path_buf.appendSlice(allocator, input.refresh_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTopicRefreshOutput {
    var result: DescribeTopicRefreshOutput = try aws.json.parseJsonObject(
        DescribeTopicRefreshOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
