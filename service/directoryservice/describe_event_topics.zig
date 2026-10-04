const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventTopic = @import("event_topic.zig").EventTopic;

pub const DescribeEventTopicsInput = struct {
    /// The Directory ID for which to get the list of associated Amazon SNS topics.
    /// If this member
    /// is null, associations for all Directory IDs are returned.
    directory_id: ?[]const u8 = null,

    /// A list of Amazon SNS topic names for which to obtain the information. If
    /// this member is
    /// null, all associations for the specified Directory ID are returned.
    ///
    /// An empty list results in an `InvalidParameterException` being
    /// thrown.
    topic_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .topic_names = "TopicNames",
    };
};

pub const DescribeEventTopicsOutput = struct {
    /// A list of Amazon SNS topic names that receive status messages from the
    /// specified Directory
    /// ID.
    event_topics: ?[]const EventTopic = null,

    pub const json_field_names = .{
        .event_topics = "EventTopics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventTopicsInput, options: CallOptions) !DescribeEventTopicsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEventTopicsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeEventTopics");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEventTopicsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEventTopicsOutput, body, allocator);
}
