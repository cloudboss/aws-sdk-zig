const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorDestinationSummary = @import("connector_destination_summary.zig").ConnectorDestinationSummary;

pub const ListConnectorDestinationsInput = struct {
    /// The identifier of the cloud connector to filter connector destinations by.
    cloud_connector_id: ?[]const u8 = null,

    /// The maximum number of connector destinations to return in a single response.
    max_results: ?i32 = null,

    /// A token used for pagination of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_connector_id = "CloudConnectorId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListConnectorDestinationsOutput = struct {
    /// The list of connector destinations that match the specified criteria.
    connector_destination_list: ?[]const ConnectorDestinationSummary = null,

    /// A token used for pagination of results when there are more connector
    /// destinations than can be returned in a single response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_destination_list = "ConnectorDestinationList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConnectorDestinationsInput, options: CallOptions) !ListConnectorDestinationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConnectorDestinationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/connector-destinations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.cloud_connector_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "CloudConnectorId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConnectorDestinationsOutput {
    var result: ListConnectorDestinationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListConnectorDestinationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
