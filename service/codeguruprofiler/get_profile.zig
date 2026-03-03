const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetProfileInput = struct {
    /// The format of the returned profiling data. The format maps to the
    /// `Accept` and `Content-Type` headers of the
    /// HTTP request. You can specify one of the following:
    /// or the default .
    ///
    /// * `application/json` — standard JSON format
    ///
    /// * `application/x-amzn-ion` — the Amazon Ion data format. For more
    ///   information,
    /// see [Amazon Ion](http://amzn.github.io/ion-docs/).
    accept: ?[]const u8 = null,

    /// The end time of the requested profile. Specify using
    /// the ISO 8601 format. For example,
    /// 2020-06-01T13:15:02.001Z represents 1 millisecond past June 1, 2020 1:15:02
    /// PM UTC.
    ///
    /// If you specify `endTime`, then you must also specify `period`
    /// or `startTime`, but not both.
    end_time: ?i64 = null,

    /// The maximum depth of the stacks in the code that is represented in
    /// the aggregated profile. For example, if CodeGuru Profiler finds a method
    /// `A`,
    /// which calls method `B`, which calls method `C`, which
    /// calls method `D`, then the depth is 4. If the `maxDepth` is
    /// set to 2, then the aggregated profile contains representations of methods
    /// `A`
    /// and `B`.
    max_depth: ?i32 = null,

    /// Used with `startTime` or `endTime` to specify
    /// the time range for the returned aggregated profile. Specify using
    /// the ISO 8601 format. For example, `P1DT1H1M1S`.
    ///
    /// To get the latest aggregated profile, specify only `period`.
    period: ?[]const u8 = null,

    /// The name of the profiling group to get.
    profiling_group_name: []const u8,

    /// The start time of the profile to get. Specify using
    /// the ISO 8601 format. For example,
    /// 2020-06-01T13:15:02.001Z represents 1 millisecond past June 1, 2020 1:15:02
    /// PM UTC.
    ///
    /// If you specify `startTime`, then you must also specify `period`
    /// or `endTime`, but not both.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .accept = "accept",
        .end_time = "endTime",
        .max_depth = "maxDepth",
        .period = "period",
        .profiling_group_name = "profilingGroupName",
        .start_time = "startTime",
    };
};

pub const GetProfileOutput = struct {
    /// The content encoding of the profile.
    content_encoding: ?[]const u8 = null,

    /// The content type of the profile in the payload. It is
    /// either `application/json` or the default
    /// `application/x-amzn-ion`.
    content_type: []const u8,

    /// Information about the profile.
    profile: []const u8,

    pub const json_field_names = .{
        .content_encoding = "contentEncoding",
        .content_type = "contentType",
        .profile = "profile",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProfileInput, options: Options) !GetProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguruprofiler", "CodeGuruProfiler", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/profilingGroups/");
    try path_buf.appendSlice(allocator, input.profiling_group_name);
    try path_buf.appendSlice(allocator, "/profile");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.end_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.max_depth) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxDepth=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.period) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "period=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.start_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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
    if (input.accept) |v| {
        try request.headers.put(allocator, "Accept", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProfileOutput {
    var result: GetProfileOutput = .{};
    result.profile = try allocator.dupe(u8, body);
    _ = status;
    if (headers.get("content-encoding")) |value| {
        result.content_encoding = try allocator.dupe(u8, value);
    }
    if (headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }

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
