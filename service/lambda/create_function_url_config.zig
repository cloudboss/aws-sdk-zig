const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FunctionUrlAuthType = @import("function_url_auth_type.zig").FunctionUrlAuthType;
const Cors = @import("cors.zig").Cors;
const InvokeMode = @import("invoke_mode.zig").InvokeMode;

/// Creates a Lambda function URL with the specified configuration parameters. A
/// function URL is a dedicated HTTP(S) endpoint that you can use to invoke your
/// function.
pub const CreateFunctionUrlConfigInput = struct {
    /// The type of authentication that your function URL uses. Set to `AWS_IAM` if
    /// you want to restrict access to authenticated users only. Set to `NONE` if
    /// you want to bypass IAM authentication to create a public endpoint. For more
    /// information, see [Control access to Lambda function
    /// URLs](https://docs.aws.amazon.com/lambda/latest/dg/urls-auth.html).
    auth_type: FunctionUrlAuthType,

    /// The [cross-origin resource sharing
    /// (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) settings for
    /// your function URL.
    cors: ?Cors = null,

    /// The name or ARN of the Lambda function. **Name formats**
    ///
    /// * **Function name** – `my-function`.
    /// * **Function ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:my-function`.
    /// * **Partial ARN** – `123456789012:function:my-function`.
    ///
    /// The length constraint applies only to the full ARN. If you specify only the
    /// function name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// Use one of the following options:
    ///
    /// * `BUFFERED` – This is the default option. Lambda invokes your function
    ///   using the `Invoke` API operation. Invocation results are available when
    ///   the payload is complete. The maximum payload size is 6 MB.
    /// * `RESPONSE_STREAM` – Your function streams payload results as they become
    ///   available. Lambda invokes your function using the
    ///   `InvokeWithResponseStream` API operation. The maximum response payload
    ///   size is 200 MB.
    invoke_mode: ?InvokeMode = null,

    /// The alias name.
    qualifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_type = "AuthType",
        .cors = "Cors",
        .function_name = "FunctionName",
        .invoke_mode = "InvokeMode",
        .qualifier = "Qualifier",
    };
};

pub const CreateFunctionUrlConfigOutput = struct {
    /// The type of authentication that your function URL uses. Set to `AWS_IAM` if
    /// you want to restrict access to authenticated users only. Set to `NONE` if
    /// you want to bypass IAM authentication to create a public endpoint. For more
    /// information, see [Control access to Lambda function
    /// URLs](https://docs.aws.amazon.com/lambda/latest/dg/urls-auth.html).
    auth_type: FunctionUrlAuthType,

    /// The [cross-origin resource sharing
    /// (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) settings for
    /// your function URL.
    cors: ?Cors = null,

    /// When the function URL was created, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    creation_time: []const u8,

    /// The Amazon Resource Name (ARN) of your function.
    function_arn: []const u8,

    /// The HTTP URL endpoint for your function.
    function_url: []const u8,

    /// Use one of the following options:
    ///
    /// * `BUFFERED` – This is the default option. Lambda invokes your function
    ///   using the `Invoke` API operation. Invocation results are available when
    ///   the payload is complete. The maximum payload size is 6 MB.
    /// * `RESPONSE_STREAM` – Your function streams payload results as they become
    ///   available. Lambda invokes your function using the
    ///   `InvokeWithResponseStream` API operation. The maximum response payload
    ///   size is 200 MB.
    invoke_mode: ?InvokeMode = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateFunctionUrlConfigOutput) void {
        self._arena.deinit();
    }

    pub const json_field_names = .{
        .auth_type = "AuthType",
        .cors = "Cors",
        .creation_time = "CreationTime",
        .function_arn = "FunctionArn",
        .function_url = "FunctionUrl",
        .invoke_mode = "InvokeMode",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateFunctionUrlConfigInput, options: Options) !CreateFunctionUrlConfigOutput {
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateFunctionUrlConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("lambda", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/2021-10-31/functions/");
    try path_buf.appendSlice(alloc, input.function_name);
    try path_buf.appendSlice(alloc, "/url");
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.qualifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "Qualifier=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"AuthType\":");
    try aws.json.writeValue(@TypeOf(input.auth_type), input.auth_type, alloc, &body_buf);
    has_prev = true;
    if (input.cors) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Cors\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.invoke_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"InvokeMode\":");
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
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateFunctionUrlConfigOutput {
    var result: CreateFunctionUrlConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFunctionUrlConfigOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";

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
