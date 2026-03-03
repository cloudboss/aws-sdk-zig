const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InvocationType = @import("invocation_type.zig").InvocationType;
const LogType = @import("log_type.zig").LogType;

pub const InvokeInput = struct {
    /// Up to 3,583 bytes of base64-encoded data about the invoking client to pass
    /// to the function in the context object. Lambda passes the `ClientContext`
    /// object to your function for synchronous invocations only.
    client_context: ?[]const u8 = null,

    /// Optional unique name for the durable execution. When you start your special
    /// function, you can give it a unique name to identify this specific execution.
    /// It's like giving a nickname to a task.
    durable_execution_name: ?[]const u8 = null,

    /// The name or ARN of the Lambda function, version, or alias. **Name formats**
    ///
    /// * **Function name** – `my-function` (name-only), `my-function:v1` (with
    ///   alias).
    /// * **Function ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:my-function`.
    /// * **Partial ARN** – `123456789012:function:my-function`.
    ///
    /// You can append a version number or alias to any of the formats. The length
    /// constraint applies only to the full ARN. If you specify only the function
    /// name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// Choose from the following options.
    ///
    /// * `RequestResponse` (default) – Invoke the function synchronously. Keep the
    ///   connection open until the function returns a response or times out. The
    ///   API response includes the function response and additional data.
    /// * `Event` – Invoke the function asynchronously. Send events that fail
    ///   multiple times to the function's dead-letter queue (if one is configured).
    ///   The API response only includes a status code.
    /// * `DryRun` – Validate parameter values and verify that the user or role has
    ///   permission to invoke the function.
    invocation_type: ?InvocationType = null,

    /// Set to `Tail` to include the execution log in the response. Applies to
    /// synchronously invoked functions only.
    log_type: ?LogType = null,

    /// The JSON that you want to provide to your Lambda function as input. The
    /// maximum payload size is 6 MB for synchronous invocations and 1 MB for
    /// asynchronous invocations.
    ///
    /// You can enter the JSON directly. For example, `--payload '{ "key": "value"
    /// }'`. You can also specify a file path. For example, `--payload
    /// file://payload.json`.
    payload: ?[]const u8 = null,

    /// Specify a version or alias to invoke a published version of the function.
    qualifier: ?[]const u8 = null,

    /// The identifier of the tenant in a multi-tenant Lambda function.
    tenant_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_context = "ClientContext",
        .durable_execution_name = "DurableExecutionName",
        .function_name = "FunctionName",
        .invocation_type = "InvocationType",
        .log_type = "LogType",
        .payload = "Payload",
        .qualifier = "Qualifier",
        .tenant_id = "TenantId",
    };
};

pub const InvokeOutput = struct {
    /// The ARN of the durable execution that was started. This is returned when
    /// invoking a durable function and provides a unique identifier for tracking
    /// the execution.
    durable_execution_arn: ?[]const u8 = null,

    /// The version of the function that executed. When you invoke a function with
    /// an alias, this indicates which version the alias resolved to.
    executed_version: ?[]const u8 = null,

    /// If present, indicates that an error occurred during function execution.
    /// Details about the error are included in the response payload.
    function_error: ?[]const u8 = null,

    /// The last 4 KB of the execution log, which is base64-encoded.
    log_result: ?[]const u8 = null,

    /// The response from the function, or an error object.
    payload: ?[]const u8 = null,

    /// The HTTP status code is in the 200 range for a successful request. For the
    /// `RequestResponse` invocation type, this status code is 200. For the `Event`
    /// invocation type, this status code is 202. For the `DryRun` invocation type,
    /// the status code is 204.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .durable_execution_arn = "DurableExecutionArn",
        .executed_version = "ExecutedVersion",
        .function_error = "FunctionError",
        .log_result = "LogResult",
        .payload = "Payload",
        .status_code = "StatusCode",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeInput, options: Options) !InvokeOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/2015-03-31/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/invocations");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.qualifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Qualifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body = input.payload orelse "";

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.client_context) |v| {
        try request.headers.put(allocator, "X-Amz-Client-Context", v);
    }
    if (input.durable_execution_name) |v| {
        try request.headers.put(allocator, "X-Amz-Durable-Execution-Name", v);
    }
    if (input.invocation_type) |v| {
        try request.headers.put(allocator, "X-Amz-Invocation-Type", @tagName(v));
    }
    if (input.log_type) |v| {
        try request.headers.put(allocator, "X-Amz-Log-Type", @tagName(v));
    }
    if (input.tenant_id) |v| {
        try request.headers.put(allocator, "X-Amz-Tenant-Id", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InvokeOutput {
    var result: InvokeOutput = .{};
    if (body.len > 0) {
        result.payload = try allocator.dupe(u8, body);
    }
    result.status_code = @intCast(status);
    if (headers.get("x-amz-durable-execution-arn")) |value| {
        result.durable_execution_arn = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-executed-version")) |value| {
        result.executed_version = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-function-error")) |value| {
        result.function_error = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-log-result")) |value| {
        result.log_result = try allocator.dupe(u8, value);
    }

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

    if (std.mem.eql(u8, error_code, "CallbackTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .callback_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityProviderLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .capacity_provider_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeSigningConfigNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .code_signing_config_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeStorageExceededException")) {
        return .{ .arena = arena, .kind = .{ .code_storage_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeVerificationFailedException")) {
        return .{ .arena = arena, .kind = .{ .code_verification_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DurableExecutionAlreadyStartedException")) {
        return .{ .arena = arena, .kind = .{ .durable_execution_already_started_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EC2AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .ec2_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EC2ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .ec2_throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EC2UnexpectedException")) {
        return .{ .arena = arena, .kind = .{ .ec2_unexpected_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountConnectivityException")) {
        return .{ .arena = arena, .kind = .{ .efs_mount_connectivity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountFailureException")) {
        return .{ .arena = arena, .kind = .{ .efs_mount_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSMountTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .efs_mount_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EFSIOException")) {
        return .{ .arena = arena, .kind = .{ .efsio_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ENILimitReachedException")) {
        return .{ .arena = arena, .kind = .{ .eni_limit_reached_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FunctionVersionsPerCapacityProviderLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .function_versions_per_capacity_provider_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCodeSignatureException")) {
        return .{ .arena = arena, .kind = .{ .invalid_code_signature_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidRequestContentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRuntimeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_runtime_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityGroupIDException")) {
        return .{ .arena = arena, .kind = .{ .invalid_security_group_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnetIDException")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidZipFileException")) {
        return .{ .arena = arena, .kind = .{ .invalid_zip_file_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoPublishedVersionException")) {
        return .{ .arena = arena, .kind = .{ .no_published_version_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedConcurrencyConfigNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .provisioned_concurrency_config_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RecursiveInvocationException")) {
        return .{ .arena = arena, .kind = .{ .recursive_invocation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .request_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .arena = arena, .kind = .{ .resource_conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SerializedRequestEntityTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .serialized_request_entity_too_large_exception = .{
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
    if (std.mem.eql(u8, error_code, "SnapStartException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapStartTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .snap_start_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetIPAddressLimitReachedException")) {
        return .{ .arena = arena, .kind = .{ .subnet_ip_address_limit_reached_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedMediaTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_media_type_exception = .{
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
