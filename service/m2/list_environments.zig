const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EngineType = @import("engine_type.zig").EngineType;
const EnvironmentSummary = @import("environment_summary.zig").EnvironmentSummary;

pub const ListEnvironmentsInput = struct {
    /// The engine type for the runtime environment.
    engine_type: ?EngineType = null,

    /// The maximum number of runtime environments to return.
    max_results: ?i32 = null,

    /// The names of the runtime environments. Must be unique within the account.
    names: ?[]const []const u8 = null,

    /// A pagination token to control the number of runtime environments displayed
    /// in the
    /// list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .engine_type = "engineType",
        .max_results = "maxResults",
        .names = "names",
        .next_token = "nextToken",
    };
};

pub const ListEnvironmentsOutput = struct {
    /// Returns a list of summary details for all the runtime environments in your
    /// account.
    environments: ?[]const EnvironmentSummary = null,

    /// A pagination token that's returned when the response doesn't contain all the
    /// runtime
    /// environments.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .environments = "environments",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEnvironmentsInput, options: CallOptions) !ListEnvironmentsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "m2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEnvironmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/environments";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.engine_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "engineType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
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
    if (input.names) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "names=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEnvironmentsOutput {
    var result: ListEnvironmentsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListEnvironmentsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
