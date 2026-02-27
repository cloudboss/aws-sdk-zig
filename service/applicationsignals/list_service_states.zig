const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeFilter = @import("attribute_filter.zig").AttributeFilter;
const ServiceState = @import("service_state.zig").ServiceState;

pub const ListServiceStatesInput = struct {
    /// A list of attribute filters to narrow down the services. You can filter by
    /// platform, environment, or other service attributes.
    attribute_filters: ?[]const AttributeFilter = null,

    /// The Amazon Web Services account ID to filter service states by. Use this to
    /// limit results to services from a specific account.
    aws_account_id: ?[]const u8 = null,

    /// The end of the time period to retrieve service state information for. When
    /// used in a raw HTTP Query API, it is formatted as epoch time in seconds. For
    /// example, `1698778057`.
    end_time: i64,

    /// If you are using this operation in a monitoring account, specify `true` to
    /// include service states from source accounts in the returned data.
    include_linked_accounts: bool = false,

    /// The maximum number of service states to return in one operation. If you omit
    /// this parameter, the default of 20 is used.
    max_results: i32 = 20,

    /// Include this value, if it was returned by the previous operation, to get the
    /// next set of service states.
    next_token: ?[]const u8 = null,

    /// The start of the time period to retrieve service state information for. When
    /// used in a raw HTTP Query API, it is formatted as epoch time in seconds. For
    /// example, `1698778057`.
    start_time: i64,

    pub const json_field_names = .{
        .attribute_filters = "AttributeFilters",
        .aws_account_id = "AwsAccountId",
        .end_time = "EndTime",
        .include_linked_accounts = "IncludeLinkedAccounts",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .start_time = "StartTime",
    };
};

pub const ListServiceStatesOutput = struct {
    /// The end of the time period that the returned information applies to. When
    /// used in a raw HTTP Query API, it is formatted as epoch time in seconds. For
    /// example, `1698778057`.
    end_time: i64,

    /// Include this value in your next use of this API to get the next set of
    /// service states.
    next_token: ?[]const u8 = null,

    /// An array of structures, where each structure contains information about the
    /// state of one service, including its latest change events such as
    /// deployments.
    service_states: ?[]const ServiceState = null,

    /// The start of the time period that the returned information applies to. When
    /// used in a raw HTTP Query API, it is formatted as epoch time in seconds. For
    /// example, `1698778057`.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .next_token = "NextToken",
        .service_states = "ServiceStates",
        .start_time = "StartTime",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceStatesInput, options: Options) !ListServiceStatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "applicationsignals");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ListServiceStatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationsignals", "Application Signals", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/service/states";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.attribute_filters) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AttributeFilters\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.aws_account_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AwsAccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"EndTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, alloc, &body_buf);
    has_prev = true;
    if (input.include_linked_accounts) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IncludeLinkedAccounts\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"StartTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListServiceStatesOutput {
    var result: ListServiceStatesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListServiceStatesOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
