const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConnectorOperationInput, options: CallOptions) !DescribeConnectorOperationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafkaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConnectorOperationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/connectorOperations/");
    try path_buf.appendSlice(allocator, input.connector_operation_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConnectorOperationOutput {
    const result: DescribeConnectorOperationOutput = try aws.json.parseJsonObject(
        DescribeConnectorOperationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
