const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ComputeConfig = @import("compute_config.zig").ComputeConfig;
const NetworkConfig = @import("network_config.zig").NetworkConfig;
const TimeoutConfig = @import("timeout_config.zig").TimeoutConfig;
const TriggerSource = @import("trigger_source.zig").TriggerSource;
const CellInformation = @import("cell_information.zig").CellInformation;
const EnvironmentConfig = @import("environment_config.zig").EnvironmentConfig;
const NotebookRunError = @import("notebook_run_error.zig").NotebookRunError;
const NotebookRunStatus = @import("notebook_run_status.zig").NotebookRunStatus;
const StorageConfig = @import("storage_config.zig").StorageConfig;

pub const StartNotebookRunInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    /// This field is automatically populated if not provided.
    client_token: ?[]const u8 = null,

    /// The compute configuration for the notebook run, including instance type and
    /// environment version.
    compute_configuration: ?ComputeConfig = null,

    /// The identifier of the Amazon DataZone domain in which the notebook run is
    /// started.
    domain_identifier: []const u8,

    /// The metadata for the notebook run, specified as key-value pairs. You can
    /// specify up to 50 entries, with keys up to 128 characters and values up to
    /// 1024 characters.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The network configuration for the notebook run, including network access
    /// type and optional VPC settings.
    network_configuration: ?NetworkConfig = null,

    /// The identifier of the notebook to run.
    notebook_identifier: []const u8,

    /// The identifier of the project that owns the notebook run.
    owning_project_identifier: []const u8,

    /// The sensitive parameters for the notebook run, specified as key-value pairs.
    /// You can specify up to 50 entries, with keys up to 128 characters and values
    /// up to 1024 characters.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The identifier of the schedule associated with the notebook run.
    schedule_identifier: ?[]const u8 = null,

    /// The timeout configuration for the notebook run. The default timeout is 720
    /// minutes (12 hours) and the maximum is 1440 minutes (24 hours).
    timeout_configuration: ?TimeoutConfig = null,

    /// The source that triggered the notebook run.
    trigger_source: ?TriggerSource = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .compute_configuration = "computeConfiguration",
        .domain_identifier = "domainIdentifier",
        .metadata = "metadata",
        .network_configuration = "networkConfiguration",
        .notebook_identifier = "notebookIdentifier",
        .owning_project_identifier = "owningProjectIdentifier",
        .parameters = "parameters",
        .schedule_identifier = "scheduleIdentifier",
        .timeout_configuration = "timeoutConfiguration",
        .trigger_source = "triggerSource",
    };
};

pub const StartNotebookRunOutput = struct {
    /// The ordered list of cells in the notebook run.
    cell_order: ?[]const CellInformation = null,

    /// The timestamp of when the notebook run completed.
    completed_at: ?i64 = null,

    /// The compute configuration of the notebook run.
    compute_configuration: ?ComputeConfig = null,

    /// The timestamp of when the notebook run was created.
    created_at: ?i64 = null,

    /// The identifier of the user who created the notebook run.
    created_by: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain.
    domain_id: []const u8,

    /// The environment configuration of the notebook run, including image version
    /// and package settings.
    environment_configuration: ?EnvironmentConfig = null,

    /// The error details if the notebook run failed.
    @"error": ?NotebookRunError = null,

    /// The identifier of the notebook run.
    id: []const u8,

    /// The metadata of the notebook run.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The network configuration of the notebook run.
    network_configuration: ?NetworkConfig = null,

    /// The identifier of the notebook.
    notebook_id: []const u8,

    /// The identifier of the project that owns the notebook run.
    owning_project_id: []const u8,

    /// The sensitive parameters of the notebook run.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The identifier of the schedule associated with the notebook run.
    schedule_id: ?[]const u8 = null,

    /// The timestamp of when the notebook run started executing.
    started_at: ?i64 = null,

    /// The status of the notebook run.
    status: NotebookRunStatus,

    /// The storage configuration of the notebook run, including the Amazon Simple
    /// Storage Service path and KMS key ARN.
    storage_configuration: ?StorageConfig = null,

    /// The timeout configuration of the notebook run.
    timeout_configuration: ?TimeoutConfig = null,

    /// The source that triggered the notebook run.
    trigger_source: ?TriggerSource = null,

    /// The timestamp of when the notebook run was last updated.
    updated_at: ?i64 = null,

    /// The identifier of the user who last updated the notebook run.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .cell_order = "cellOrder",
        .completed_at = "completedAt",
        .compute_configuration = "computeConfiguration",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .environment_configuration = "environmentConfiguration",
        .@"error" = "error",
        .id = "id",
        .metadata = "metadata",
        .network_configuration = "networkConfiguration",
        .notebook_id = "notebookId",
        .owning_project_id = "owningProjectId",
        .parameters = "parameters",
        .schedule_id = "scheduleId",
        .started_at = "startedAt",
        .status = "status",
        .storage_configuration = "storageConfiguration",
        .timeout_configuration = "timeoutConfiguration",
        .trigger_source = "triggerSource",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartNotebookRunInput, options: CallOptions) !StartNotebookRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartNotebookRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/notebook-runs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.compute_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"computeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.network_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"networkConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"notebookIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.notebook_identifier), input.notebook_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"owningProjectIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.owning_project_identifier), input.owning_project_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.schedule_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scheduleIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.timeout_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timeoutConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.trigger_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"triggerSource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartNotebookRunOutput {
    var result: StartNotebookRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartNotebookRunOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
