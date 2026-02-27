const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConnectorOperationState = @import("connector_operation_state.zig").ConnectorOperationState;
const ConnectorOperationType = @import("connector_operation_type.zig").ConnectorOperationType;
const StateDescription = @import("state_description.zig").StateDescription;
const ConnectorOperationStep = @import("connector_operation_step.zig").ConnectorOperationStep;
const WorkerSetting = @import("worker_setting.zig").WorkerSetting;

pub const DescribeConnectorOperationInput = struct {
    /// ARN of the connector operation to be described.
    connector_operation_arn: []const u8,

    pub const json_field_names = .{
        .connector_operation_arn = "connectorOperationArn",
    };
};

pub const DescribeConnectorOperationOutput = struct {
    /// The Amazon Resource Name (ARN) of the connector.
    connector_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the connector operation.
    connector_operation_arn: ?[]const u8 = null,

    /// The state of the connector operation.
    connector_operation_state: ?ConnectorOperationState = null,

    /// The type of connector operation performed.
    connector_operation_type: ?ConnectorOperationType = null,

    /// The time when the operation was created.
    creation_time: ?i64 = null,

    /// The time when the operation ended.
    end_time: ?i64 = null,

    error_info: ?StateDescription = null,

    /// The array of operation steps taken.
    operation_steps: ?[]const ConnectorOperationStep = null,

    /// The origin connector configuration.
    origin_connector_configuration: ?[]const aws.map.StringMapEntry = null,

    /// The origin worker setting.
    origin_worker_setting: ?WorkerSetting = null,

    /// The target connector configuration.
    target_connector_configuration: ?[]const aws.map.StringMapEntry = null,

    /// The target worker setting.
    target_worker_setting: ?WorkerSetting = null,

    pub const json_field_names = .{
        .connector_arn = "connectorArn",
        .connector_operation_arn = "connectorOperationArn",
        .connector_operation_state = "connectorOperationState",
        .connector_operation_type = "connectorOperationType",
        .creation_time = "creationTime",
        .end_time = "endTime",
        .error_info = "errorInfo",
        .operation_steps = "operationSteps",
        .origin_connector_configuration = "originConnectorConfiguration",
        .origin_worker_setting = "originWorkerSetting",
        .target_connector_configuration = "targetConnectorConfiguration",
        .target_worker_setting = "targetWorkerSetting",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConnectorOperationInput, options: Options) !DescribeConnectorOperationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kafkaconnect");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeConnectorOperationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v1/connectorOperations/");
    try path_buf.appendSlice(alloc, input.connector_operation_arn);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeConnectorOperationOutput {
    var result: DescribeConnectorOperationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeConnectorOperationOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
