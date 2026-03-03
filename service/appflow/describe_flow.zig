const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DestinationFlowConfig = @import("destination_flow_config.zig").DestinationFlowConfig;
const FlowStatus = @import("flow_status.zig").FlowStatus;
const ExecutionDetails = @import("execution_details.zig").ExecutionDetails;
const MetadataCatalogDetail = @import("metadata_catalog_detail.zig").MetadataCatalogDetail;
const MetadataCatalogConfig = @import("metadata_catalog_config.zig").MetadataCatalogConfig;
const SourceFlowConfig = @import("source_flow_config.zig").SourceFlowConfig;
const Task = @import("task.zig").Task;
const TriggerConfig = @import("trigger_config.zig").TriggerConfig;

pub const DescribeFlowInput = struct {
    /// The specified name of the flow. Spaces are not allowed. Use underscores (_)
    /// or hyphens
    /// (-) only.
    flow_name: []const u8,

    pub const json_field_names = .{
        .flow_name = "flowName",
    };
};

pub const DescribeFlowOutput = struct {
    /// Specifies when the flow was created.
    created_at: ?i64 = null,

    /// The ARN of the user who created the flow.
    created_by: ?[]const u8 = null,

    /// A description of the flow.
    description: ?[]const u8 = null,

    /// The configuration that controls how Amazon AppFlow transfers data to the
    /// destination
    /// connector.
    destination_flow_config_list: ?[]const DestinationFlowConfig = null,

    /// The flow's Amazon Resource Name (ARN).
    flow_arn: ?[]const u8 = null,

    /// The specified name of the flow. Spaces are not allowed. Use underscores (_)
    /// or hyphens
    /// (-) only.
    flow_name: ?[]const u8 = null,

    /// Indicates the current status of the flow.
    flow_status: ?FlowStatus = null,

    /// Contains an error message if the flow status is in a suspended or error
    /// state. This
    /// applies only to scheduled or event-triggered flows.
    flow_status_message: ?[]const u8 = null,

    /// The ARN (Amazon Resource Name) of the Key Management Service (KMS) key you
    /// provide for
    /// encryption. This is required if you do not want to use the Amazon
    /// AppFlow-managed KMS
    /// key. If you don't provide anything here, Amazon AppFlow uses the Amazon
    /// AppFlow-managed KMS key.
    kms_arn: ?[]const u8 = null,

    /// Describes the details of the most recent flow run.
    last_run_execution_details: ?ExecutionDetails = null,

    /// Describes the metadata catalog, metadata table, and data partitions that
    /// Amazon AppFlow used for the associated flow run.
    last_run_metadata_catalog_details: ?[]const MetadataCatalogDetail = null,

    /// Specifies when the flow was last updated.
    last_updated_at: ?i64 = null,

    /// Specifies the user name of the account that performed the most recent
    /// update.
    last_updated_by: ?[]const u8 = null,

    /// Specifies the configuration that Amazon AppFlow uses when it catalogs the
    /// data that's
    /// transferred by the associated flow. When Amazon AppFlow catalogs the data
    /// from a flow, it
    /// stores metadata in a data catalog.
    metadata_catalog_config: ?MetadataCatalogConfig = null,

    /// The version number of your data schema. Amazon AppFlow assigns this version
    /// number.
    /// The version number increases by one when you change any of the following
    /// settings in your flow
    /// configuration:
    ///
    /// * Source-to-destination field mappings
    ///
    /// * Field data types
    ///
    /// * Partition keys
    schema_version: ?i64 = null,

    /// The configuration that controls how Amazon AppFlow retrieves data from the
    /// source
    /// connector.
    source_flow_config: ?SourceFlowConfig = null,

    /// The tags used to organize, track, or control access for your flow.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of tasks that Amazon AppFlow performs while transferring the data in
    /// the flow
    /// run.
    tasks: ?[]const Task = null,

    /// The trigger settings that determine how and when the flow runs.
    trigger_config: ?TriggerConfig = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .destination_flow_config_list = "destinationFlowConfigList",
        .flow_arn = "flowArn",
        .flow_name = "flowName",
        .flow_status = "flowStatus",
        .flow_status_message = "flowStatusMessage",
        .kms_arn = "kmsArn",
        .last_run_execution_details = "lastRunExecutionDetails",
        .last_run_metadata_catalog_details = "lastRunMetadataCatalogDetails",
        .last_updated_at = "lastUpdatedAt",
        .last_updated_by = "lastUpdatedBy",
        .metadata_catalog_config = "metadataCatalogConfig",
        .schema_version = "schemaVersion",
        .source_flow_config = "sourceFlowConfig",
        .tags = "tags",
        .tasks = "tasks",
        .trigger_config = "triggerConfig",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFlowInput, options: Options) !DescribeFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appflow");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/describe-flow";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"flowName\":");
    try aws.json.writeValue(@TypeOf(input.flow_name), input.flow_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFlowOutput {
    var result: DescribeFlowOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeFlowOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConnectorAuthenticationException")) {
        return .{ .arena = arena, .kind = .{ .connector_authentication_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConnectorServerException")) {
        return .{ .arena = arena, .kind = .{ .connector_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
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
