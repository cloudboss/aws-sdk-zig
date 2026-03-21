const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ProgressEvent = @import("progress_event.zig").ProgressEvent;

pub const UpdateResourceInput = struct {
    /// A unique identifier to ensure the idempotency of the resource request. As a
    /// best practice, specify this token to ensure idempotency, so that Amazon Web
    /// Services Cloud Control API can
    /// accurately distinguish between request retries and new resource requests.
    /// You
    /// might retry a resource request to ensure that it was successfully received.
    ///
    /// A client token is valid for 36 hours once used. After that, a resource
    /// request with the same client token is treated as a new request.
    ///
    /// If you
    /// do not specify a client token, one is generated for inclusion in the
    /// request.
    ///
    /// For more information, see [Ensuring
    /// resource operation requests are
    /// unique](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations.html#resource-operations-idempotency) in the *Amazon Web Services Cloud Control API User
    /// Guide*.
    client_token: ?[]const u8 = null,

    /// The identifier for the resource.
    ///
    /// You can specify the primary identifier, or any secondary identifier
    /// defined for the resource type in its resource schema. You can only specify
    /// one identifier. Primary identifiers can be specified as a string or JSON;
    /// secondary identifiers must be specified as JSON.
    ///
    /// For compound primary identifiers (that is, one that consists of
    /// multiple resource properties strung together), to specify the primary
    /// identifier as a string, list the property values *in the order
    /// they are specified* in the primary identifier definition,
    /// separated by `|`.
    ///
    /// For more information, see [Identifying
    /// resources](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-identifier.html) in the *Amazon Web Services Cloud Control API User Guide*.
    identifier: []const u8,

    /// A JavaScript Object Notation (JSON) document listing the patch operations
    /// that represent
    /// the updates to apply to the current resource properties. For details, see
    /// [Composing the patch
    /// document](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-update.html#resource-operations-update-patch) in the *Amazon Web Services Cloud Control API User
    /// Guide*.
    patch_document: []const u8,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management
    /// (IAM) role for Cloud Control API to use when performing this resource
    /// operation. The role specified must have the permissions required for this
    /// operation. The necessary permissions for each event handler are defined in
    /// the
    /// `
    /// [handlers](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-schema.html#schema-properties-handlers)
    /// `
    /// section of the [resource type
    /// definition
    /// schema](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-schema.html).
    ///
    /// If you do not specify a role, Cloud Control API uses a temporary session
    /// created using
    /// your Amazon Web Services user credentials.
    ///
    /// For more information, see [Specifying
    /// credentials](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations.html#resource-operations-permissions) in the *Amazon Web Services Cloud Control API User Guide*.
    role_arn: ?[]const u8 = null,

    /// The name of the resource type.
    type_name: []const u8,

    /// For private resource types, the type version to use in this resource
    /// operation. If you do not specify a resource version, CloudFormation
    /// uses the default version.
    type_version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .identifier = "Identifier",
        .patch_document = "PatchDocument",
        .role_arn = "RoleArn",
        .type_name = "TypeName",
        .type_version_id = "TypeVersionId",
    };
};

pub const UpdateResourceOutput = struct {
    /// Represents the current status of the resource update request.
    ///
    /// Use the `RequestToken` of the `ProgressEvent` with
    /// [GetResourceRequestStatus](https://docs.aws.amazon.com/cloudcontrolapi/latest/APIReference/API_GetResourceRequestStatus.html) to return the current status of a resource operation
    /// request.
    progress_event: ?ProgressEvent = null,

    pub const json_field_names = .{
        .progress_event = "ProgressEvent",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateResourceInput, options: CallOptions) !UpdateResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudapiservice");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudcontrolapi", "CloudControl", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CloudApiService.UpdateResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateResourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateResourceOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClientTokenConflictException")) {
        return .{ .arena = arena, .kind = .{ .client_token_conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "ConcurrentOperationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GeneralServiceException")) {
        return .{ .arena = arena, .kind = .{ .general_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HandlerFailureException")) {
        return .{ .arena = arena, .kind = .{ .handler_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HandlerInternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .handler_internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCredentialsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_credentials_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NetworkFailureException")) {
        return .{ .arena = arena, .kind = .{ .network_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotStabilizedException")) {
        return .{ .arena = arena, .kind = .{ .not_stabilized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotUpdatableException")) {
        return .{ .arena = arena, .kind = .{ .not_updatable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PrivateTypeException")) {
        return .{ .arena = arena, .kind = .{ .private_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTokenNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .request_token_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceInternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .service_internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "TypeNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .type_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedActionException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_action_exception = .{
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
