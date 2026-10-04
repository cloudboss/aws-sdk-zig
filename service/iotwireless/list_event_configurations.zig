const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventNotificationResourceType = @import("event_notification_resource_type.zig").EventNotificationResourceType;
const EventConfigurationItem = @import("event_configuration_item.zig").EventConfigurationItem;

pub const ListEventConfigurationsInput = struct {
    max_results: ?i32 = null,

    /// To retrieve the next set of results, the `nextToken` value from a previous
    /// response; otherwise **null** to receive the first set of
    /// results.
    next_token: ?[]const u8 = null,

    /// Resource type to filter event configurations.
    resource_type: EventNotificationResourceType,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_type = "ResourceType",
    };
};

pub const ListEventConfigurationsOutput = struct {
    /// Event configurations of all events for a single resource.
    event_configurations_list: ?[]const EventConfigurationItem = null,

    /// To retrieve the next set of results, the `nextToken` value from a previous
    /// response; otherwise **null** to receive the first set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_configurations_list = "EventConfigurationsList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEventConfigurationsInput, options: CallOptions) !ListEventConfigurationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEventConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/event-configurations";

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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "resourceType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.resource_type.wireName());
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEventConfigurationsOutput {
    var result: ListEventConfigurationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListEventConfigurationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
