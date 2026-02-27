const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResourceDescription = @import("resource_description.zig").ResourceDescription;

pub const ListResourcesInput = struct {
    /// Reserved.
    max_results: ?i32 = null,

    /// If the previous paginated request didn't return all of the remaining
    /// results,
    /// the response object's `NextToken` parameter value is set to a token.
    /// To retrieve the next set of results, call this action again and assign that
    /// token to
    /// the request object's `NextToken` parameter. If there are no remaining
    /// results, the previous response object's `NextToken` parameter is set to
    /// `null`.
    next_token: ?[]const u8 = null,

    /// The resource model to use to select the resources to return.
    resource_model: ?[]const u8 = null,

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
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_model = "ResourceModel",
        .role_arn = "RoleArn",
        .type_name = "TypeName",
        .type_version_id = "TypeVersionId",
    };
};

pub const ListResourcesOutput = struct {
    /// If the request doesn't return all of the remaining results,
    /// `NextToken` is set to a token. To retrieve the next set of results, call
    /// `ListResources` again and assign that token to the request object's
    /// `NextToken` parameter. If the request returns all results,
    /// `NextToken` is set to null.
    next_token: ?[]const u8 = null,

    /// Information about the specified resources, including primary identifier and
    /// resource
    /// model.
    resource_descriptions: ?[]const ResourceDescription = null,

    /// The name of the resource type.
    type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_descriptions = "ResourceDescriptions",
        .type_name = "TypeName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourcesInput, options: Options) !ListResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudcontrol");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ListResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudcontrol", "CloudControl", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "CloudApiService.ListResources");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListResourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListResourcesOutput, body, alloc);
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
