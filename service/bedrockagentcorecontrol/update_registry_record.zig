const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const UpdatedDescription = @import("updated_description.zig").UpdatedDescription;
const UpdatedDescriptors = @import("updated_descriptors.zig").UpdatedDescriptors;
const DescriptorType = @import("descriptor_type.zig").DescriptorType;
const UpdatedSynchronizationConfiguration = @import("updated_synchronization_configuration.zig").UpdatedSynchronizationConfiguration;
const UpdatedSynchronizationType = @import("updated_synchronization_type.zig").UpdatedSynchronizationType;
const Descriptors = @import("descriptors.zig").Descriptors;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;
const SynchronizationConfiguration = @import("synchronization_configuration.zig").SynchronizationConfiguration;
const SynchronizationType = @import("synchronization_type.zig").SynchronizationType;

pub const UpdateRegistryRecordInput = struct {
    /// The updated description for the registry record. To clear the description,
    /// include the `UpdatedDescription` wrapper with `optionalValue` not specified.
    description: ?UpdatedDescription = null,

    /// The updated descriptor-type-specific configuration containing the resource
    /// schema and metadata. Uses PATCH semantics where individual descriptor fields
    /// can be updated independently.
    descriptors: ?UpdatedDescriptors = null,

    /// The updated descriptor type for the registry record. Changing the descriptor
    /// type may require updating the `descriptors` field to match the new type's
    /// schema requirements.
    descriptor_type: ?DescriptorType = null,

    /// The updated name for the registry record.
    name: ?[]const u8 = null,

    /// The identifier of the registry record to update. You can specify either the
    /// Amazon Resource Name (ARN) or the ID of the record.
    record_id: []const u8,

    /// The version of the registry record for optimistic locking. If provided, it
    /// must match the current version of the record. The service automatically
    /// increments the version after a successful update.
    record_version: ?[]const u8 = null,

    /// The identifier of the registry containing the record. You can specify either
    /// the Amazon Resource Name (ARN) or the ID of the registry.
    registry_id: []const u8,

    /// The updated synchronization configuration for the registry record.
    synchronization_configuration: ?UpdatedSynchronizationConfiguration = null,

    /// The updated synchronization type for the registry record.
    synchronization_type: ?UpdatedSynchronizationType = null,

    /// Whether to trigger synchronization using the stored or provided
    /// configuration. When set to `true`, the service will synchronize the record
    /// metadata from the configured external source.
    trigger_synchronization: ?bool = null,

    pub const json_field_names = .{
        .description = "description",
        .descriptors = "descriptors",
        .descriptor_type = "descriptorType",
        .name = "name",
        .record_id = "recordId",
        .record_version = "recordVersion",
        .registry_id = "registryId",
        .synchronization_configuration = "synchronizationConfiguration",
        .synchronization_type = "synchronizationType",
        .trigger_synchronization = "triggerSynchronization",
    };
};

pub const UpdateRegistryRecordOutput = struct {
    /// The timestamp when the registry record was created.
    created_at: i64,

    /// The description of the updated registry record.
    description: ?[]const u8 = null,

    /// The descriptor-type-specific configuration of the updated registry record.
    /// For details, see the `Descriptors` data type.
    descriptors: ?Descriptors = null,

    /// The descriptor type of the updated registry record. Possible values are
    /// `MCP`, `A2A`, `CUSTOM`, and `AGENT_SKILLS`.
    descriptor_type: DescriptorType,

    /// The name of the updated registry record.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the updated registry record.
    record_arn: []const u8,

    /// The unique identifier of the updated registry record.
    record_id: []const u8,

    /// The version of the updated registry record.
    record_version: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the registry that contains the updated
    /// record.
    registry_arn: []const u8,

    /// The current status of the updated registry record. Possible values include
    /// `CREATING`, `DRAFT`, `APPROVED`, `PENDING_APPROVAL`, `REJECTED`,
    /// `DEPRECATED`, `UPDATING`, `CREATE_FAILED`, and `UPDATE_FAILED`.
    status: RegistryRecordStatus,

    /// The reason for the current status of the updated registry record.
    status_reason: ?[]const u8 = null,

    /// The synchronization configuration of the updated registry record.
    synchronization_configuration: ?SynchronizationConfiguration = null,

    /// The synchronization type of the updated registry record.
    synchronization_type: ?SynchronizationType = null,

    /// The timestamp when the registry record was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .descriptors = "descriptors",
        .descriptor_type = "descriptorType",
        .name = "name",
        .record_arn = "recordArn",
        .record_id = "recordId",
        .record_version = "recordVersion",
        .registry_arn = "registryArn",
        .status = "status",
        .status_reason = "statusReason",
        .synchronization_configuration = "synchronizationConfiguration",
        .synchronization_type = "synchronizationType",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRegistryRecordInput, options: CallOptions) !UpdateRegistryRecordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrock-agentcore");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRegistryRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
    try path_buf.appendSlice(allocator, "/records/");
    try path_buf.appendSlice(allocator, input.record_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.descriptors) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"descriptors\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.descriptor_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"descriptorType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.record_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recordVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.synchronization_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"synchronizationConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.synchronization_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"synchronizationType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.trigger_synchronization) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"triggerSynchronization\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRegistryRecordOutput {
    var result: UpdateRegistryRecordOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateRegistryRecordOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
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
    if (std.mem.eql(u8, error_code, "DecryptionFailure")) {
        return .{ .arena = arena, .kind = .{ .decryption_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionFailure")) {
        return .{ .arena = arena, .kind = .{ .encryption_failure = .{
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
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
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
