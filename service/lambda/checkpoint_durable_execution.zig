const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const OperationUpdate = @import("operation_update.zig").OperationUpdate;
const CheckpointUpdatedExecutionState = @import("checkpoint_updated_execution_state.zig").CheckpointUpdatedExecutionState;

/// Saves the progress of a [durable
/// function](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html) execution during runtime. This API is used by the Lambda durable functions SDK to checkpoint completed steps and schedule asynchronous operations. You typically don't need to call this API directly as the SDK handles checkpointing automatically.
///
/// Each checkpoint operation consumes the current checkpoint token and returns
/// a new one for the next checkpoint. This ensures that checkpoints are applied
/// in the correct order and prevents duplicate or out-of-order state updates.
pub const CheckpointDurableExecutionInput = struct {
    /// A unique token that identifies the current checkpoint state. This token is
    /// provided by the Lambda runtime and must be used to ensure checkpoints are
    /// applied in the correct order. Each checkpoint operation consumes this token
    /// and returns a new one.
    checkpoint_token: []const u8,

    /// An optional idempotency token to ensure that duplicate checkpoint requests
    /// are handled correctly. If provided, Lambda uses this token to detect and
    /// handle duplicate requests within a 15-minute window.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the durable execution.
    durable_execution_arn: []const u8,

    /// An array of state updates to apply during this checkpoint. Each update
    /// represents a change to the execution state, such as completing a step,
    /// starting a callback, or scheduling a timer. Updates are applied atomically
    /// as part of the checkpoint operation.
    updates: ?[]const OperationUpdate = null,

    pub const json_field_names = .{
        .checkpoint_token = "CheckpointToken",
        .client_token = "ClientToken",
        .durable_execution_arn = "DurableExecutionArn",
        .updates = "Updates",
    };
};

pub const CheckpointDurableExecutionOutput = struct {
    /// A new checkpoint token to use for the next checkpoint operation. This token
    /// replaces the one provided in the request and must be used for subsequent
    /// checkpoints to maintain proper ordering.
    checkpoint_token: ?[]const u8 = null,

    /// Updated execution state information that includes any changes that occurred
    /// since the last checkpoint, such as completed callbacks or expired timers.
    /// This allows the SDK to update its internal state during replay.
    new_execution_state: ?CheckpointUpdatedExecutionState = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CheckpointDurableExecutionOutput) void {
        if (self.checkpoint_token) |v| {
            self.allocator.free(v);
        }
    }

    pub const json_field_names = .{
        .checkpoint_token = "CheckpointToken",
        .new_execution_state = "NewExecutionState",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CheckpointDurableExecutionInput, options: Options) !CheckpointDurableExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lambda");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CheckpointDurableExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("lambda", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/2025-12-01/durable-executions/");
    try path_buf.appendSlice(alloc, input.durable_execution_arn);
    try path_buf.appendSlice(alloc, "/checkpoint");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"CheckpointToken\":");
    try aws.json.writeValue(@TypeOf(input.checkpoint_token), input.checkpoint_token, alloc, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.updates) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Updates\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CheckpointDurableExecutionOutput {
    var result: CheckpointDurableExecutionOutput = .{ .allocator = alloc };
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CheckpointDurableExecutionOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = findJsonValue(body, "message") orelse findJsonValue(body, "Message") orelse "";

    if (std.mem.eql(u8, error_code, "CallbackTimeoutException")) {
        return .{ .callback_timeout_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CapacityProviderLimitExceededException")) {
        return .{ .capacity_provider_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CodeSigningConfigNotFoundException")) {
        return .{ .code_signing_config_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CodeStorageExceededException")) {
        return .{ .code_storage_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "CodeVerificationFailedException")) {
        return .{ .code_verification_failed_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "DurableExecutionAlreadyStartedException")) {
        return .{ .durable_execution_already_started_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EC2AccessDeniedException")) {
        return .{ .ec2_access_denied_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EC2ThrottledException")) {
        return .{ .ec2_throttled_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EC2UnexpectedException")) {
        return .{ .ec2_unexpected_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountConnectivityException")) {
        return .{ .efs_mount_connectivity_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountFailureException")) {
        return .{ .efs_mount_failure_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountTimeoutException")) {
        return .{ .efs_mount_timeout_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "EFSIOException")) {
        return .{ .efsio_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ENILimitReachedException")) {
        return .{ .eni_limit_reached_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "FunctionVersionsPerCapacityProviderLimitExceededException")) {
        return .{ .function_versions_per_capacity_provider_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCodeSignatureException")) {
        return .{ .invalid_code_signature_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .invalid_parameter_value_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestContentException")) {
        return .{ .invalid_request_content_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRuntimeException")) {
        return .{ .invalid_runtime_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityGroupIDException")) {
        return .{ .invalid_security_group_id_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnetIDException")) {
        return .{ .invalid_subnet_id_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidZipFileException")) {
        return .{ .invalid_zip_file_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .kms_access_denied_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .kms_disabled_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .kms_invalid_state_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .kms_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "NoPublishedVersionException")) {
        return .{ .no_published_version_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        return .{ .policy_length_exceeded_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .precondition_failed_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedConcurrencyConfigNotFoundException")) {
        return .{ .provisioned_concurrency_config_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "RecursiveInvocationException")) {
        return .{ .recursive_invocation_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "RequestTooLargeException")) {
        return .{ .request_too_large_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .resource_conflict_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .resource_in_use_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .resource_not_found_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .resource_not_ready_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SerializedRequestEntityTooLargeException")) {
        return .{ .serialized_request_entity_too_large_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .service_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartException")) {
        return .{ .snap_start_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartNotReadyException")) {
        return .{ .snap_start_not_ready_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartTimeoutException")) {
        return .{ .snap_start_timeout_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "SubnetIPAddressLimitReachedException")) {
        return .{ .subnet_ip_address_limit_reached_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .too_many_requests_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedMediaTypeException")) {
        return .{ .unsupported_media_type_exception = .{
            .message = error_message,
            .request_id = "",
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = "",
        .http_status = status,
    } };
}

fn findJsonValue(json: []const u8, key: []const u8) ?[]const u8 {
    var buf: [258]u8 = undefined;
    if (key.len + 2 > buf.len) return null;
    buf[0] = 0x22;
    @memcpy(buf[1..][0..key.len], key);
    buf[key.len + 1] = 0x22;
    const search = buf[0 .. key.len + 2];
    const key_start = std.mem.indexOf(u8, json, search) orelse return null;
    var pos = key_start + search.len;

    while (pos < json.len) : (pos += 1) {
        if (json[pos] != ' ' and json[pos] != ':') break;
    }
    if (pos >= json.len) return null;

    if (json[pos] == 0x22) {
        const start = pos + 1;
        const end = std.mem.indexOfScalarPos(u8, json, start, 0x22) orelse return null;
        return json[start..end];
    }

    const start = pos;
    while (pos < json.len) : (pos += 1) {
        if (json[pos] == ',' or json[pos] == '}' or json[pos] == ' ') break;
    }
    return json[start..pos];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
