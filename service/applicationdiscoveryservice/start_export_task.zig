const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExportDataFormat = @import("export_data_format.zig").ExportDataFormat;
const ExportFilter = @import("export_filter.zig").ExportFilter;
const ExportPreferences = @import("export_preferences.zig").ExportPreferences;

pub const StartExportTaskInput = struct {
    /// The end timestamp for exported data from the single Application Discovery
    /// Agent
    /// selected in the filters. If no value is specified, exported data includes
    /// the most recent data
    /// collected by the agent.
    end_time: ?i64 = null,

    /// The file format for the returned export data. Default value is `CSV`.
    /// **Note:**
    /// *The*
    /// `GRAPHML`
    /// *option has been deprecated.*
    export_data_format: ?[]const ExportDataFormat = null,

    /// If a filter is present, it selects the single `agentId` of the Application
    /// Discovery Agent for which data is exported. The `agentId` can be found in
    /// the
    /// results of the `DescribeAgents` API or CLI. If no filter is present,
    /// `startTime` and `endTime` are ignored and exported data includes both
    /// Amazon Web Services Application Discovery Service Agentless Collector
    /// collectors data and summary data from Application Discovery
    /// Agent agents.
    filters: ?[]const ExportFilter = null,

    /// Indicates the type of data that needs to be exported. Only one
    /// [ExportPreferences](https://docs.aws.amazon.com/application-discovery/latest/APIReference/API_ExportPreferences.html) can be enabled at any time.
    preferences: ?ExportPreferences = null,

    /// The start timestamp for exported data from the single Application Discovery
    /// Agent
    /// selected in the filters. If no value is specified, data is exported starting
    /// from the first
    /// data collected by the agent.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .export_data_format = "exportDataFormat",
        .filters = "filters",
        .preferences = "preferences",
        .start_time = "startTime",
    };
};

pub const StartExportTaskOutput = struct {
    /// A unique identifier used to query the status of an export request.
    export_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .export_id = "exportId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartExportTaskInput, options: Options) !StartExportTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "applicationdiscoveryservice");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartExportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationdiscoveryservice", "Application Discovery Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPoseidonService_V2015_11_01.StartExportTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartExportTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartExportTaskOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AuthorizationErrorException")) {
        return .{ .arena = arena, .kind = .{ .authorization_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictErrorException")) {
        return .{ .arena = arena, .kind = .{ .conflict_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HomeRegionNotSetException")) {
        return .{ .arena = arena, .kind = .{ .home_region_not_set_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServerInternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .server_internal_error_exception = .{
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
