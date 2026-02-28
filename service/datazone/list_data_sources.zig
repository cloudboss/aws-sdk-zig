const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;
const DataSourceSummary = @import("data_source_summary.zig").DataSourceSummary;

pub const ListDataSourcesInput = struct {
    /// The ID of the connection.
    connection_identifier: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which to list the data
    /// sources.
    domain_identifier: []const u8,

    /// The identifier of the environment in which to list the data sources.
    environment_identifier: ?[]const u8 = null,

    /// The maximum number of data sources to return in a single call to
    /// `ListDataSources`. When the number of data sources to be listed is greater
    /// than the value of `MaxResults`, the response contains a `NextToken` value
    /// that you can use in a subsequent call to `ListDataSources` to list the next
    /// set of data sources.
    max_results: ?i32 = null,

    /// The name of the data source.
    name: ?[]const u8 = null,

    /// When the number of data sources is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of data sources, the response
    /// includes a pagination token named `NextToken`. You can specify this
    /// `NextToken` value in a subsequent call to `ListDataSources` to list the next
    /// set of data sources.
    next_token: ?[]const u8 = null,

    /// The identifier of the project in which to list data sources.
    project_identifier: []const u8,

    /// The status of the data source.
    status: ?DataSourceStatus = null,

    /// The type of the data source.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_identifier = "connectionIdentifier",
        .domain_identifier = "domainIdentifier",
        .environment_identifier = "environmentIdentifier",
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .project_identifier = "projectIdentifier",
        .status = "status",
        .@"type" = "type",
    };
};

pub const ListDataSourcesOutput = struct {
    /// The results of the `ListDataSources` action.
    items: ?[]const DataSourceSummary = null,

    /// When the number of data sources is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of data sources, the response
    /// includes a pagination token named `NextToken`. You can specify this
    /// `NextToken` value in a subsequent call to `ListDataSources` to list the next
    /// set of data sources.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataSourcesInput, options: Options) !ListDataSourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datazone");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ListDataSourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v2/domains/");
    try path_buf.appendSlice(alloc, input.domain_identifier);
    try path_buf.appendSlice(alloc, "/data-sources");
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.connection_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "connectionIdentifier=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.environment_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "environmentIdentifier=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try query_buf.appendSlice(alloc, num_str);
        }
        query_has_prev = true;
    }
    if (input.name) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "name=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "nextToken=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "projectIdentifier=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.project_identifier);
    query_has_prev = true;
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "status=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (input.@"type") |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "type=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListDataSourcesOutput {
    var result: ListDataSourcesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListDataSourcesOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
