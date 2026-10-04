const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventBus = @import("event_bus.zig").EventBus;

pub const ListEventBusesInput = struct {
    /// Specifying this limits the number of results returned by this operation. The
    /// operation
    /// also returns a NextToken which you can use in a subsequent operation to
    /// retrieve the next set
    /// of results.
    limit: ?i32 = null,

    /// Specifying this limits the results to only those event buses with names that
    /// start with
    /// the specified prefix.
    name_prefix: ?[]const u8 = null,

    /// The token returned by a previous call to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .name_prefix = "NamePrefix",
        .next_token = "NextToken",
    };
};

pub const ListEventBusesOutput = struct {
    /// This list of event buses.
    event_buses: ?[]const EventBus = null,

    /// A token you can use in a subsequent operation to retrieve the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_buses = "EventBuses",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEventBusesInput, options: CallOptions) !ListEventBusesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEventBusesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.ListEventBuses");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEventBusesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListEventBusesOutput, body, allocator);
}
