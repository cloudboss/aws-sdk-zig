const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WirelessGatewayTaskDefinitionType = @import("wireless_gateway_task_definition_type.zig").WirelessGatewayTaskDefinitionType;
const UpdateWirelessGatewayTaskEntry = @import("update_wireless_gateway_task_entry.zig").UpdateWirelessGatewayTaskEntry;

pub const ListWirelessGatewayTaskDefinitionsInput = struct {
    /// The maximum number of results to return in this operation.
    max_results: ?i32 = null,

    /// To retrieve the next set of results, the `nextToken` value from a previous
    /// response; otherwise **null** to receive the first set of
    /// results.
    next_token: ?[]const u8 = null,

    /// A filter to list only the wireless gateway task definitions that use this
    /// task
    /// definition type.
    task_definition_type: ?WirelessGatewayTaskDefinitionType = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .task_definition_type = "TaskDefinitionType",
    };
};

pub const ListWirelessGatewayTaskDefinitionsOutput = struct {
    /// The token to use to get the next set of results, or **null** if there are no
    /// additional results.
    next_token: ?[]const u8 = null,

    /// The list of task definitions.
    task_definitions: ?[]const UpdateWirelessGatewayTaskEntry = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .task_definitions = "TaskDefinitions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWirelessGatewayTaskDefinitionsInput, options: CallOptions) !ListWirelessGatewayTaskDefinitionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWirelessGatewayTaskDefinitionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/wireless-gateway-task-definitions";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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
    if (input.task_definition_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "taskDefinitionType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWirelessGatewayTaskDefinitionsOutput {
    var result: ListWirelessGatewayTaskDefinitionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListWirelessGatewayTaskDefinitionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
