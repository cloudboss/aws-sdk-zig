const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoaderIdResult = @import("loader_id_result.zig").LoaderIdResult;

pub const ListLoaderJobsInput = struct {
    /// An optional parameter that can be used to exclude the load IDs of queued
    /// load requests when requesting a list of load IDs by setting the parameter to
    /// `FALSE`. The default value is `TRUE`.
    include_queued_loads: ?bool = null,

    /// The number of load IDs to list. Must be a positive integer greater than zero
    /// and not more than `100` (which is the default).
    limit: ?i32 = null,

    pub const json_field_names = .{
        .include_queued_loads = "includeQueuedLoads",
        .limit = "limit",
    };
};

pub const ListLoaderJobsOutput = struct {
    /// The requested list of job IDs.
    payload: ?LoaderIdResult = null,

    /// Returns the status of the job list request.
    status: []const u8,

    pub const json_field_names = .{
        .payload = "payload",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLoaderJobsInput, options: CallOptions) !ListLoaderJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-db", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLoaderJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/loader";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_queued_loads) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeQueuedLoads=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.limit) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "limit=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLoaderJobsOutput {
    const result: ListLoaderJobsOutput = try aws.json.parseJsonObject(
        ListLoaderJobsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
