const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Anomaly = @import("anomaly.zig").Anomaly;
const Recommendation = @import("recommendation.zig").Recommendation;

pub const GetRecommendationsInput = struct {
    /// The start time of the profile to get analysis data about. You must specify
    /// `startTime` and `endTime`.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    end_time: i64,

    /// The language used to provide analysis. Specify using a string that is one
    /// of the following `BCP 47` language codes.
    ///
    /// * `de-DE` - German, Germany
    ///
    /// * `en-GB` - English, United Kingdom
    ///
    /// * `en-US` - English, United States
    ///
    /// * `es-ES` - Spanish, Spain
    ///
    /// * `fr-FR` - French, France
    ///
    /// * `it-IT` - Italian, Italy
    ///
    /// * `ja-JP` - Japanese, Japan
    ///
    /// * `ko-KR` - Korean, Republic of Korea
    ///
    /// * `pt-BR` - Portugese, Brazil
    ///
    /// * `zh-CN` - Chinese, China
    ///
    /// * `zh-TW` - Chinese, Taiwan
    locale: ?[]const u8 = null,

    /// The name of the profiling group to get analysis data about.
    profiling_group_name: []const u8,

    /// The end time of the profile to get analysis data about. You must specify
    /// `startTime` and `endTime`.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .locale = "locale",
        .profiling_group_name = "profilingGroupName",
        .start_time = "startTime",
    };
};

pub const GetRecommendationsOutput = struct {
    /// The list of anomalies that the analysis has found for this profile.
    anomalies: ?[]const Anomaly = null,

    /// The end time of the profile the analysis data is about. This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    profile_end_time: i64,

    /// The start time of the profile the analysis data is about. This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    profile_start_time: i64,

    /// The name of the profiling group the analysis data is about.
    profiling_group_name: []const u8,

    /// The list of recommendations that the analysis found for this profile.
    recommendations: ?[]const Recommendation = null,

    pub const json_field_names = .{
        .anomalies = "anomalies",
        .profile_end_time = "profileEndTime",
        .profile_start_time = "profileStartTime",
        .profiling_group_name = "profilingGroupName",
        .recommendations = "recommendations",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecommendationsInput, options: Options) !GetRecommendationsOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguruprofiler", "CodeGuruProfiler", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/internal/profilingGroups/");
    try path_buf.appendSlice(alloc, input.profiling_group_name);
    try path_buf.appendSlice(alloc, "/recommendations");
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "endTime=");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{input.end_time}) catch "";
        try query_buf.appendSlice(alloc, num_str);
    }
    query_has_prev = true;
    if (input.locale) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "locale=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "startTime=");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{input.start_time}) catch "";
        try query_buf.appendSlice(alloc, num_str);
    }
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetRecommendationsOutput {
    var result: GetRecommendationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRecommendationsOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
