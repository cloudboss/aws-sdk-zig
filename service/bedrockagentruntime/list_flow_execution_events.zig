const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowExecutionEventType = @import("flow_execution_event_type.zig").FlowExecutionEventType;
const FlowExecutionEvent = @import("flow_execution_event.zig").FlowExecutionEvent;

pub const ListFlowExecutionEventsInput = struct {
    /// The type of events to retrieve. Specify `Node` for node-level events or
    /// `Flow` for flow-level events.
    event_type: FlowExecutionEventType,

    /// The unique identifier of the flow execution.
    execution_identifier: []const u8,

    /// The unique identifier of the flow alias used for the execution.
    flow_alias_identifier: []const u8,

    /// The unique identifier of the flow.
    flow_identifier: []const u8,

    /// The maximum number of events to return in a single response. If more events
    /// exist than the specified maxResults value, a token is included in the
    /// response so that the remaining results can be retrieved.
    max_results: ?i32 = null,

    /// A token to retrieve the next set of results. This value is returned in the
    /// response if more results are available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_type = "eventType",
        .execution_identifier = "executionIdentifier",
        .flow_alias_identifier = "flowAliasIdentifier",
        .flow_identifier = "flowIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListFlowExecutionEventsOutput = struct {
    /// A list of events that occurred during the flow execution. Events can include
    /// node inputs and outputs, flow inputs and outputs, condition results, and
    /// failure events.
    flow_execution_events: ?[]const FlowExecutionEvent = null,

    /// A token to retrieve the next set of results. This value is returned if more
    /// results are available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .flow_execution_events = "flowExecutionEvents",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFlowExecutionEventsInput, options: CallOptions) !ListFlowExecutionEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFlowExecutionEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flows/");
    try path_buf.appendSlice(allocator, input.flow_identifier);
    try path_buf.appendSlice(allocator, "/aliases/");
    try path_buf.appendSlice(allocator, input.flow_alias_identifier);
    try path_buf.appendSlice(allocator, "/executions/");
    try path_buf.appendSlice(allocator, input.execution_identifier);
    try path_buf.appendSlice(allocator, "/events");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "eventType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.event_type.wireName());
    query_has_prev = true;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFlowExecutionEventsOutput {
    var result: ListFlowExecutionEventsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListFlowExecutionEventsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
