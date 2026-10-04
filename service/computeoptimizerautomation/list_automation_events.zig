const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomationEventFilter = @import("automation_event_filter.zig").AutomationEventFilter;
const AutomationEvent = @import("automation_event.zig").AutomationEvent;

pub const ListAutomationEventsInput = struct {
    /// The end of the time range to query for events.
    end_time_exclusive: ?i64 = null,

    /// The filters to apply to the list of automation events.
    filters: ?[]const AutomationEventFilter = null,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    /// The start of the time range to query for events.
    start_time_inclusive: ?i64 = null,

    pub const json_field_names = .{
        .end_time_exclusive = "endTimeExclusive",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .start_time_inclusive = "startTimeInclusive",
    };
};

pub const ListAutomationEventsOutput = struct {
    /// The list of automation events that match the specified criteria.
    automation_events: ?[]const AutomationEvent = null,

    /// The token to use to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .automation_events = "automationEvents",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAutomationEventsInput, options: CallOptions) !ListAutomationEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "compute-optimizer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAutomationEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aco-automation", "Compute Optimizer Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerAutomationService.ListAutomationEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAutomationEventsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAutomationEventsOutput, body, allocator);
}
