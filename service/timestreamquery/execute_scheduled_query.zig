const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduledQueryInsights = @import("scheduled_query_insights.zig").ScheduledQueryInsights;

pub const ExecuteScheduledQueryInput = struct {
    /// Not used.
    client_token: ?[]const u8 = null,

    /// The timestamp in UTC. Query will be run as if it was invoked at this
    /// timestamp.
    invocation_time: i64,

    /// Encapsulates settings for enabling `QueryInsights`.
    ///
    /// Enabling `QueryInsights` returns insights and metrics as a part of the
    /// Amazon SNS notification for the query that you executed. You can use
    /// `QueryInsights` to tune your query performance and cost.
    query_insights: ?ScheduledQueryInsights = null,

    /// ARN of the scheduled query.
    scheduled_query_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .invocation_time = "InvocationTime",
        .query_insights = "QueryInsights",
        .scheduled_query_arn = "ScheduledQueryArn",
    };
};

pub const ExecuteScheduledQueryOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteScheduledQueryInput, options: CallOptions) !ExecuteScheduledQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteScheduledQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("query.timestream", "Timestream Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.ExecuteScheduledQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteScheduledQueryOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
