const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionVersionsByCapacityProviderListItem = @import("function_versions_by_capacity_provider_list_item.zig").FunctionVersionsByCapacityProviderListItem;

pub const ListFunctionVersionsByCapacityProviderInput = struct {
    /// The name of the capacity provider to list function versions for.
    capacity_provider_name: []const u8,

    /// Specify the pagination token that's returned by a previous request to
    /// retrieve the next page of results.
    marker: ?[]const u8 = null,

    /// The maximum number of function versions to return in the response.
    max_items: ?i32 = null,

    pub const json_field_names = .{
        .capacity_provider_name = "CapacityProviderName",
        .marker = "Marker",
        .max_items = "MaxItems",
    };
};

pub const ListFunctionVersionsByCapacityProviderOutput = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider.
    capacity_provider_arn: []const u8,

    /// A list of function versions that use the specified capacity provider.
    function_versions: ?[]const FunctionVersionsByCapacityProviderListItem = null,

    /// The pagination token that's included if more results are available.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_provider_arn = "CapacityProviderArn",
        .function_versions = "FunctionVersions",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFunctionVersionsByCapacityProviderInput, options: CallOptions) !ListFunctionVersionsByCapacityProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFunctionVersionsByCapacityProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-11-30/capacity-providers/");
    try path_buf.appendSlice(allocator, input.capacity_provider_name);
    try path_buf.appendSlice(allocator, "/function-versions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxItems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFunctionVersionsByCapacityProviderOutput {
    const result: ListFunctionVersionsByCapacityProviderOutput = try aws.json.parseJsonObject(
        ListFunctionVersionsByCapacityProviderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
