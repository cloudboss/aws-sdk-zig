const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ProfilingGroupDescription = @import("profiling_group_description.zig").ProfilingGroupDescription;

pub const ListProfilingGroupsInput = struct {
    /// A `Boolean` value indicating whether to include a description. If `true`,
    /// then a list of
    /// [
    /// `ProfilingGroupDescription`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ProfilingGroupDescription.html) objects
    /// that contain detailed information about profiling groups is returned. If
    /// `false`, then
    /// a list of profiling group names is returned.
    include_description: ?bool = null,

    /// The maximum number of profiling groups results returned by
    /// `ListProfilingGroups`
    /// in paginated output. When this parameter is used, `ListProfilingGroups` only
    /// returns
    /// `maxResults` results in a single page along with a `nextToken` response
    /// element. The remaining results of the initial request
    /// can be seen by sending another `ListProfilingGroups` request with the
    /// returned
    /// `nextToken` value.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `ListProfilingGroups` request where `maxResults` was used and the results
    /// exceeded the value of that parameter. Pagination continues from the end of
    /// the previous results
    /// that returned the `nextToken` value.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve
    /// the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .include_description = "includeDescription",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListProfilingGroupsOutput = struct {
    /// The `nextToken` value to include in a future `ListProfilingGroups` request.
    /// When the results of a `ListProfilingGroups` request exceed `maxResults`,
    /// this
    /// value can be used to retrieve the next page of results. This value is `null`
    /// when there are no more
    /// results to return.
    next_token: ?[]const u8 = null,

    /// A returned list of profiling group names. A list of the names is returned
    /// only if
    /// `includeDescription` is `false`, otherwise a list of
    /// [
    /// `ProfilingGroupDescription`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ProfilingGroupDescription.html) objects
    /// is returned.
    profiling_group_names: ?[]const []const u8 = null,

    /// A returned list
    /// [
    /// `ProfilingGroupDescription`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ProfilingGroupDescription.html)
    /// objects. A list of
    /// [
    /// `ProfilingGroupDescription`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ProfilingGroupDescription.html)
    /// objects is returned only if `includeDescription` is `true`, otherwise a list
    /// of profiling group names is returned.
    profiling_groups: ?[]const ProfilingGroupDescription = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .profiling_group_names = "profilingGroupNames",
        .profiling_groups = "profilingGroups",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProfilingGroupsInput, options: CallOptions) !ListProfilingGroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codeguruprofiler");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListProfilingGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguruprofiler", "CodeGuruProfiler", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/profilingGroups";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.include_description) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeDescription=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProfilingGroupsOutput {
    var result: ListProfilingGroupsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListProfilingGroupsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
