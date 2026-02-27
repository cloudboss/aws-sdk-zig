const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataViewDestinationTypeParams = @import("data_view_destination_type_params.zig").DataViewDestinationTypeParams;
const DataViewErrorInfo = @import("data_view_error_info.zig").DataViewErrorInfo;
const DataViewStatus = @import("data_view_status.zig").DataViewStatus;

pub const GetDataViewInput = struct {
    /// The unique identifier for the Dataset used in the Dataview.
    dataset_id: []const u8,

    /// The unique identifier for the Dataview.
    data_view_id: []const u8,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
        .data_view_id = "dataViewId",
    };
};

pub const GetDataViewOutput = struct {
    /// Time range to use for the Dataview. The value is determined as epoch time in
    /// milliseconds. For example, the value for Monday, November 1, 2021 12:00:00
    /// PM UTC is specified as 1635768000000.
    as_of_timestamp: ?i64 = null,

    /// Flag to indicate Dataview should be updated automatically.
    auto_update: bool = false,

    /// The timestamp at which the Dataview was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    create_time: i64 = 0,

    /// The unique identifier for the Dataset used in the Dataview.
    dataset_id: ?[]const u8 = null,

    /// The ARN identifier of the Dataview.
    data_view_arn: ?[]const u8 = null,

    /// The unique identifier for the Dataview.
    data_view_id: ?[]const u8 = null,

    /// Options that define the destination type for the Dataview.
    destination_type_params: ?DataViewDestinationTypeParams = null,

    /// Information about an error that occurred for the Dataview.
    error_info: ?DataViewErrorInfo = null,

    /// The last time that a Dataview was modified. The value is determined as epoch
    /// time in milliseconds. For example, the value for Monday, November 1, 2021
    /// 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_time: i64 = 0,

    /// Ordered set of column names used to partition data.
    partition_columns: ?[]const []const u8 = null,

    /// Columns to be used for sorting the data.
    sort_columns: ?[]const []const u8 = null,

    /// The status of a Dataview creation.
    ///
    /// * `RUNNING` – Dataview creation is running.
    ///
    /// * `STARTING` – Dataview creation is starting.
    ///
    /// * `FAILED` – Dataview creation has failed.
    ///
    /// * `CANCELLED` – Dataview creation has been cancelled.
    ///
    /// * `TIMEOUT` – Dataview creation has timed out.
    ///
    /// * `SUCCESS` – Dataview creation has succeeded.
    ///
    /// * `PENDING` – Dataview creation is pending.
    ///
    /// * `FAILED_CLEANUP_FAILED` – Dataview creation failed and resource cleanup
    ///   failed.
    status: ?DataViewStatus = null,

    pub const json_field_names = .{
        .as_of_timestamp = "asOfTimestamp",
        .auto_update = "autoUpdate",
        .create_time = "createTime",
        .dataset_id = "datasetId",
        .data_view_arn = "dataViewArn",
        .data_view_id = "dataViewId",
        .destination_type_params = "destinationTypeParams",
        .error_info = "errorInfo",
        .last_modified_time = "lastModifiedTime",
        .partition_columns = "partitionColumns",
        .sort_columns = "sortColumns",
        .status = "status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataViewInput, options: Options) !GetDataViewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "finspacedata");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetDataViewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspacedata", "finspace data", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/datasets/");
    try path_buf.appendSlice(alloc, input.dataset_id);
    try path_buf.appendSlice(alloc, "/dataviewsv2/");
    try path_buf.appendSlice(alloc, input.data_view_id);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetDataViewOutput {
    var result: GetDataViewOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDataViewOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
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
