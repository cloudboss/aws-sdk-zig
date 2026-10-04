const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceState = @import("instance_state.zig").InstanceState;
const Instance = @import("instance.zig").Instance;

pub const ListInstancesInput = struct {
    /// The filter to ListInstances based on their names.
    instance_name_filter: ?[]const []const u8 = null,

    /// The filter to ListInstances based on their state.
    instance_state_filter: ?[]const InstanceState = null,

    /// Specify the maximum number of instances to fetch in this paginated request.
    max_results: ?i32 = null,

    /// The pagination token to fetch the next page of instances.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_name_filter = "instanceNameFilter",
        .instance_state_filter = "instanceStateFilter",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListInstancesOutput = struct {
    /// The list of instances resource data details.
    instances: ?[]const Instance = null,

    /// The pagination token to fetch the next page of instances.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instances = "instances",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInstancesInput, options: CallOptions) !ListInstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "scn", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scn", "SupplyChain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/api/instance";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.instance_name_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "instanceNameFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.instance_state_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "instanceStateFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInstancesOutput {
    var result: ListInstancesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListInstancesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
