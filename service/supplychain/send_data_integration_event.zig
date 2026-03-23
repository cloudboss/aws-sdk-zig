const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DataIntegrationEventDatasetTargetConfiguration = @import("data_integration_event_dataset_target_configuration.zig").DataIntegrationEventDatasetTargetConfiguration;
const DataIntegrationEventType = @import("data_integration_event_type.zig").DataIntegrationEventType;

pub const SendDataIntegrationEventInput = struct {
    /// The idempotent client token. The token is active for 8 hours, and within its
    /// lifetime, it ensures the request completes only once upon retry with same
    /// client token. If omitted, the AWS SDK generates a unique value so that AWS
    /// SDK can safely retry the request upon network errors.
    client_token: ?[]const u8 = null,

    /// The data payload of the event, should follow the data schema of the target
    /// dataset, or see [Data entities supported in AWS Supply
    /// Chain](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html). To send single data record, use JsonObject format; to send multiple data records, use JsonArray format.
    ///
    /// Note that for AWS Supply Chain dataset under **asc** namespace, it has a
    /// connection_id internal field that is not allowed to be provided by client
    /// directly, they will be auto populated.
    data: []const u8,

    /// The target dataset configuration for **scn.data.dataset** event type.
    dataset_target: ?DataIntegrationEventDatasetTargetConfiguration = null,

    /// Event identifier (for example, orderId for InboundOrder) used for data
    /// sharding or partitioning. Noted under one eventGroupId of same eventType and
    /// instanceId, events are processed sequentially in the order they are received
    /// by the server.
    event_group_id: []const u8,

    /// The timestamp (in epoch seconds) associated with the event. If not provided,
    /// it will be assigned with current timestamp.
    event_timestamp: ?i64 = null,

    /// The data event type.
    ///
    /// * **scn.data.dataset** - Send data directly to any specified dataset.
    ///
    /// * **scn.data.supplyplan** - Send data to
    ///   [supply_plan](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/supply-plan-entity.html) dataset.
    ///
    /// * **scn.data.shipmentstoporder** - Send data to
    ///   [shipment_stop_order](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/replenishment-shipment-stop-order-entity.html) dataset.
    ///
    /// * **scn.data.shipmentstop** - Send data to
    ///   [shipment_stop](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/replenishment-shipment-stop-entity.html) dataset.
    ///
    /// * **scn.data.shipment** - Send data to
    ///   [shipment](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/replenishment-shipment-entity.html) dataset.
    ///
    /// * **scn.data.reservation** - Send data to
    ///   [reservation](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/planning-reservation-entity.html) dataset.
    ///
    /// * **scn.data.processproduct** - Send data to
    ///   [process_product](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/operation-process-product-entity.html) dataset.
    ///
    /// * **scn.data.processoperation** - Send data to
    ///   [process_operation](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/operation-process-operation-entity.html) dataset.
    ///
    /// * **scn.data.processheader** - Send data to
    ///   [process_header](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/operation-process-header-entity.html) dataset.
    ///
    /// * **scn.data.forecast** - Send data to
    ///   [forecast](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/forecast-forecast-entity.html) dataset.
    ///
    /// * **scn.data.inventorylevel** - Send data to
    ///   [inv_level](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/inventory_mgmnt-inv-level-entity.html) dataset.
    ///
    /// * **scn.data.inboundorder** - Send data to
    ///   [inbound_order](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/replenishment-inbound-order-entity.html) dataset.
    ///
    /// * **scn.data.inboundorderline** - Send data to
    ///   [inbound_order_line](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/replenishment-inbound-order-line-entity.html) dataset.
    ///
    /// * **scn.data.inboundorderlineschedule** - Send data to
    ///   [inbound_order_line_schedule](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/replenishment-inbound-order-line-schedule-entity.html) dataset.
    ///
    /// * **scn.data.outboundorderline** - Send data to
    ///   [outbound_order_line](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/outbound-fulfillment-order-line-entity.html) dataset.
    ///
    /// * **scn.data.outboundshipment** - Send data to
    ///   [outbound_shipment](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/outbound-fulfillment-shipment-entity.html) dataset.
    event_type: DataIntegrationEventType,

    /// The AWS Supply Chain instance identifier.
    instance_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .data = "data",
        .dataset_target = "datasetTarget",
        .event_group_id = "eventGroupId",
        .event_timestamp = "eventTimestamp",
        .event_type = "eventType",
        .instance_id = "instanceId",
    };
};

pub const SendDataIntegrationEventOutput = struct {
    /// The unique event identifier.
    event_id: []const u8,

    pub const json_field_names = .{
        .event_id = "eventId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendDataIntegrationEventInput, options: CallOptions) !SendDataIntegrationEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "scn");

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendDataIntegrationEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scn", "SupplyChain", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/api-data/data-integration/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/data-integration-events");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"data\":");
    try aws.json.writeValue(@TypeOf(input.data), input.data, allocator, &body_buf);
    has_prev = true;
    if (input.dataset_target) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"datasetTarget\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"eventGroupId\":");
    try aws.json.writeValue(@TypeOf(input.event_group_id), input.event_group_id, allocator, &body_buf);
    has_prev = true;
    if (input.event_timestamp) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"eventTimestamp\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"eventType\":");
    try aws.json.writeValue(@TypeOf(input.event_type), input.event_type, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendDataIntegrationEventOutput {
    var result: SendDataIntegrationEventOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SendDataIntegrationEventOutput, body, allocator);
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
