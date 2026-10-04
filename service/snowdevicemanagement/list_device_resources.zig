const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceSummary = @import("resource_summary.zig").ResourceSummary;

pub const ListDeviceResourcesInput = struct {
    /// The ID of the managed device that you are listing the resources of.
    managed_device_id: []const u8,

    /// The maximum number of resources per page.
    max_results: ?i32 = null,

    /// A pagination token to continue to the next page of results.
    next_token: ?[]const u8 = null,

    /// A structure used to filter the results by type of resource.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .managed_device_id = "managedDeviceId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .@"type" = "type",
    };
};

pub const ListDeviceResourcesOutput = struct {
    /// A pagination token to continue to the next page of results.
    next_token: ?[]const u8 = null,

    /// A structure defining the resource's type, Amazon Resource Name (ARN), and
    /// ID.
    resources: ?[]const ResourceSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .resources = "resources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDeviceResourcesInput, options: CallOptions) !ListDeviceResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "snow-device-management", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDeviceResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snow-device-management", "Snow Device Management", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/managed-device/");
    try path_buf.appendSlice(allocator, input.managed_device_id);
    try path_buf.appendSlice(allocator, "/resources");
    const path = try path_buf.toOwnedSlice(allocator);

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
    if (input.@"type") |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "type=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDeviceResourcesOutput {
    const result: ListDeviceResourcesOutput = try aws.json.parseJsonObject(
        ListDeviceResourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
