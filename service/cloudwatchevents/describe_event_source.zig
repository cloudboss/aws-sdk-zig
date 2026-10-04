const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventSourceState = @import("event_source_state.zig").EventSourceState;

pub const DescribeEventSourceInput = struct {
    /// The name of the partner event source to display the details of.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DescribeEventSourceOutput = struct {
    /// The ARN of the partner event source.
    arn: ?[]const u8 = null,

    /// The name of the SaaS partner that created the event source.
    created_by: ?[]const u8 = null,

    /// The date and time that the event source was created.
    creation_time: ?i64 = null,

    /// The date and time that the event source will expire if you do not create a
    /// matching event
    /// bus.
    expiration_time: ?i64 = null,

    /// The name of the partner event source.
    name: ?[]const u8 = null,

    /// The state of the event source. If it is ACTIVE, you have already created a
    /// matching event
    /// bus for this event source, and that event bus is active. If it is PENDING,
    /// either you haven't
    /// yet created a matching event bus, or that event bus is deactivated. If it is
    /// DELETED, you have
    /// created a matching event bus, but the event source has since been deleted.
    state: ?EventSourceState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .expiration_time = "ExpirationTime",
        .name = "Name",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventSourceInput, options: CallOptions) !DescribeEventSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "events", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEventSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "CloudWatch Events", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.DescribeEventSource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEventSourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEventSourceOutput, body, allocator);
}
