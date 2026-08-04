const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;

pub const ListGitHubAccountTokenNamesInput = struct {
    /// An identifier returned from the previous `ListGitHubAccountTokenNames`
    /// call. It can be used to return the next set of names in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
    };
};

pub const ListGitHubAccountTokenNamesOutput = struct {
    /// If a large amount of information is returned, an identifier is also
    /// returned. It can
    /// be used in a subsequent `ListGitHubAccountTokenNames` call to return the
    /// next
    /// set of names in the list.
    next_token: ?[]const u8 = null,

    /// A list of names of connections to GitHub accounts.
    token_name_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .token_name_list = "tokenNameList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGitHubAccountTokenNamesInput, options: CallOptions) !ListGitHubAccountTokenNamesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codedeploy", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListGitHubAccountTokenNamesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codedeploy", "CodeDeploy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.ListGitHubAccountTokenNames");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGitHubAccountTokenNamesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListGitHubAccountTokenNamesOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AlarmsLimitExceededException")) {
        const parsed_error: ?errors.AlarmsLimitExceededException = aws.json.parseJsonObject(errors.AlarmsLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .alarms_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApplicationAlreadyExistsException")) {
        const parsed_error: ?errors.ApplicationAlreadyExistsException = aws.json.parseJsonObject(errors.ApplicationAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .application_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApplicationDoesNotExistException")) {
        const parsed_error: ?errors.ApplicationDoesNotExistException = aws.json.parseJsonObject(errors.ApplicationDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .application_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApplicationLimitExceededException")) {
        const parsed_error: ?errors.ApplicationLimitExceededException = aws.json.parseJsonObject(errors.ApplicationLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .application_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApplicationNameRequiredException")) {
        const parsed_error: ?errors.ApplicationNameRequiredException = aws.json.parseJsonObject(errors.ApplicationNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .application_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ArnNotSupportedException")) {
        const parsed_error: ?errors.ArnNotSupportedException = aws.json.parseJsonObject(errors.ArnNotSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .arn_not_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BatchLimitExceededException")) {
        const parsed_error: ?errors.BatchLimitExceededException = aws.json.parseJsonObject(errors.BatchLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .batch_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BucketNameFilterRequiredException")) {
        const parsed_error: ?errors.BucketNameFilterRequiredException = aws.json.parseJsonObject(errors.BucketNameFilterRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .bucket_name_filter_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentAlreadyCompletedException")) {
        const parsed_error: ?errors.DeploymentAlreadyCompletedException = aws.json.parseJsonObject(errors.DeploymentAlreadyCompletedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_already_completed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentConfigAlreadyExistsException")) {
        const parsed_error: ?errors.DeploymentConfigAlreadyExistsException = aws.json.parseJsonObject(errors.DeploymentConfigAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_config_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentConfigDoesNotExistException")) {
        const parsed_error: ?errors.DeploymentConfigDoesNotExistException = aws.json.parseJsonObject(errors.DeploymentConfigDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_config_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentConfigInUseException")) {
        const parsed_error: ?errors.DeploymentConfigInUseException = aws.json.parseJsonObject(errors.DeploymentConfigInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_config_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentConfigLimitExceededException")) {
        const parsed_error: ?errors.DeploymentConfigLimitExceededException = aws.json.parseJsonObject(errors.DeploymentConfigLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_config_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentConfigNameRequiredException")) {
        const parsed_error: ?errors.DeploymentConfigNameRequiredException = aws.json.parseJsonObject(errors.DeploymentConfigNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_config_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentDoesNotExistException")) {
        const parsed_error: ?errors.DeploymentDoesNotExistException = aws.json.parseJsonObject(errors.DeploymentDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentGroupAlreadyExistsException")) {
        const parsed_error: ?errors.DeploymentGroupAlreadyExistsException = aws.json.parseJsonObject(errors.DeploymentGroupAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_group_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentGroupDoesNotExistException")) {
        const parsed_error: ?errors.DeploymentGroupDoesNotExistException = aws.json.parseJsonObject(errors.DeploymentGroupDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_group_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentGroupLimitExceededException")) {
        const parsed_error: ?errors.DeploymentGroupLimitExceededException = aws.json.parseJsonObject(errors.DeploymentGroupLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_group_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentGroupNameRequiredException")) {
        const parsed_error: ?errors.DeploymentGroupNameRequiredException = aws.json.parseJsonObject(errors.DeploymentGroupNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_group_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentIdRequiredException")) {
        const parsed_error: ?errors.DeploymentIdRequiredException = aws.json.parseJsonObject(errors.DeploymentIdRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_id_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentIsNotInReadyStateException")) {
        const parsed_error: ?errors.DeploymentIsNotInReadyStateException = aws.json.parseJsonObject(errors.DeploymentIsNotInReadyStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_is_not_in_ready_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentLimitExceededException")) {
        const parsed_error: ?errors.DeploymentLimitExceededException = aws.json.parseJsonObject(errors.DeploymentLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentNotStartedException")) {
        const parsed_error: ?errors.DeploymentNotStartedException = aws.json.parseJsonObject(errors.DeploymentNotStartedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_not_started_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentTargetDoesNotExistException")) {
        const parsed_error: ?errors.DeploymentTargetDoesNotExistException = aws.json.parseJsonObject(errors.DeploymentTargetDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_target_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentTargetIdRequiredException")) {
        const parsed_error: ?errors.DeploymentTargetIdRequiredException = aws.json.parseJsonObject(errors.DeploymentTargetIdRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_target_id_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentTargetListSizeExceededException")) {
        const parsed_error: ?errors.DeploymentTargetListSizeExceededException = aws.json.parseJsonObject(errors.DeploymentTargetListSizeExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_target_list_size_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DescriptionTooLongException")) {
        const parsed_error: ?errors.DescriptionTooLongException = aws.json.parseJsonObject(errors.DescriptionTooLongException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .description_too_long_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ECSServiceMappingLimitExceededException")) {
        const parsed_error: ?errors.ECSServiceMappingLimitExceededException = aws.json.parseJsonObject(errors.ECSServiceMappingLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ecs_service_mapping_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GitHubAccountTokenDoesNotExistException")) {
        const parsed_error: ?errors.GitHubAccountTokenDoesNotExistException = aws.json.parseJsonObject(errors.GitHubAccountTokenDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .git_hub_account_token_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GitHubAccountTokenNameRequiredException")) {
        const parsed_error: ?errors.GitHubAccountTokenNameRequiredException = aws.json.parseJsonObject(errors.GitHubAccountTokenNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .git_hub_account_token_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IamArnRequiredException")) {
        const parsed_error: ?errors.IamArnRequiredException = aws.json.parseJsonObject(errors.IamArnRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .iam_arn_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IamSessionArnAlreadyRegisteredException")) {
        const parsed_error: ?errors.IamSessionArnAlreadyRegisteredException = aws.json.parseJsonObject(errors.IamSessionArnAlreadyRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .iam_session_arn_already_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IamUserArnAlreadyRegisteredException")) {
        const parsed_error: ?errors.IamUserArnAlreadyRegisteredException = aws.json.parseJsonObject(errors.IamUserArnAlreadyRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .iam_user_arn_already_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IamUserArnRequiredException")) {
        const parsed_error: ?errors.IamUserArnRequiredException = aws.json.parseJsonObject(errors.IamUserArnRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .iam_user_arn_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceDoesNotExistException")) {
        const parsed_error: ?errors.InstanceDoesNotExistException = aws.json.parseJsonObject(errors.InstanceDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceIdRequiredException")) {
        const parsed_error: ?errors.InstanceIdRequiredException = aws.json.parseJsonObject(errors.InstanceIdRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_id_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceLimitExceededException")) {
        const parsed_error: ?errors.InstanceLimitExceededException = aws.json.parseJsonObject(errors.InstanceLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceNameAlreadyRegisteredException")) {
        const parsed_error: ?errors.InstanceNameAlreadyRegisteredException = aws.json.parseJsonObject(errors.InstanceNameAlreadyRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_name_already_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceNameRequiredException")) {
        const parsed_error: ?errors.InstanceNameRequiredException = aws.json.parseJsonObject(errors.InstanceNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceNotRegisteredException")) {
        const parsed_error: ?errors.InstanceNotRegisteredException = aws.json.parseJsonObject(errors.InstanceNotRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_not_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAlarmConfigException")) {
        const parsed_error: ?errors.InvalidAlarmConfigException = aws.json.parseJsonObject(errors.InvalidAlarmConfigException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_alarm_config_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidApplicationNameException")) {
        const parsed_error: ?errors.InvalidApplicationNameException = aws.json.parseJsonObject(errors.InvalidApplicationNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_application_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidArnException")) {
        const parsed_error: ?errors.InvalidArnException = aws.json.parseJsonObject(errors.InvalidArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutoRollbackConfigException")) {
        const parsed_error: ?errors.InvalidAutoRollbackConfigException = aws.json.parseJsonObject(errors.InvalidAutoRollbackConfigException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_auto_rollback_config_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutoScalingGroupException")) {
        const parsed_error: ?errors.InvalidAutoScalingGroupException = aws.json.parseJsonObject(errors.InvalidAutoScalingGroupException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_auto_scaling_group_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidBlueGreenDeploymentConfigurationException")) {
        const parsed_error: ?errors.InvalidBlueGreenDeploymentConfigurationException = aws.json.parseJsonObject(errors.InvalidBlueGreenDeploymentConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_blue_green_deployment_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidBucketNameFilterException")) {
        const parsed_error: ?errors.InvalidBucketNameFilterException = aws.json.parseJsonObject(errors.InvalidBucketNameFilterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_bucket_name_filter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidComputePlatformException")) {
        const parsed_error: ?errors.InvalidComputePlatformException = aws.json.parseJsonObject(errors.InvalidComputePlatformException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_compute_platform_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeployedStateFilterException")) {
        const parsed_error: ?errors.InvalidDeployedStateFilterException = aws.json.parseJsonObject(errors.InvalidDeployedStateFilterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployed_state_filter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentConfigNameException")) {
        const parsed_error: ?errors.InvalidDeploymentConfigNameException = aws.json.parseJsonObject(errors.InvalidDeploymentConfigNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_config_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentGroupNameException")) {
        const parsed_error: ?errors.InvalidDeploymentGroupNameException = aws.json.parseJsonObject(errors.InvalidDeploymentGroupNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_group_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentIdException")) {
        const parsed_error: ?errors.InvalidDeploymentIdException = aws.json.parseJsonObject(errors.InvalidDeploymentIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentInstanceTypeException")) {
        const parsed_error: ?errors.InvalidDeploymentInstanceTypeException = aws.json.parseJsonObject(errors.InvalidDeploymentInstanceTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_instance_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentStatusException")) {
        const parsed_error: ?errors.InvalidDeploymentStatusException = aws.json.parseJsonObject(errors.InvalidDeploymentStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentStyleException")) {
        const parsed_error: ?errors.InvalidDeploymentStyleException = aws.json.parseJsonObject(errors.InvalidDeploymentStyleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_style_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentTargetIdException")) {
        const parsed_error: ?errors.InvalidDeploymentTargetIdException = aws.json.parseJsonObject(errors.InvalidDeploymentTargetIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_target_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentWaitTypeException")) {
        const parsed_error: ?errors.InvalidDeploymentWaitTypeException = aws.json.parseJsonObject(errors.InvalidDeploymentWaitTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_wait_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEC2TagCombinationException")) {
        const parsed_error: ?errors.InvalidEC2TagCombinationException = aws.json.parseJsonObject(errors.InvalidEC2TagCombinationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_ec2_tag_combination_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEC2TagException")) {
        const parsed_error: ?errors.InvalidEC2TagException = aws.json.parseJsonObject(errors.InvalidEC2TagException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_ec2_tag_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidECSServiceException")) {
        const parsed_error: ?errors.InvalidECSServiceException = aws.json.parseJsonObject(errors.InvalidECSServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_ecs_service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidExternalIdException")) {
        const parsed_error: ?errors.InvalidExternalIdException = aws.json.parseJsonObject(errors.InvalidExternalIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_external_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFileExistsBehaviorException")) {
        const parsed_error: ?errors.InvalidFileExistsBehaviorException = aws.json.parseJsonObject(errors.InvalidFileExistsBehaviorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_file_exists_behavior_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidGitHubAccountTokenException")) {
        const parsed_error: ?errors.InvalidGitHubAccountTokenException = aws.json.parseJsonObject(errors.InvalidGitHubAccountTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_git_hub_account_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidGitHubAccountTokenNameException")) {
        const parsed_error: ?errors.InvalidGitHubAccountTokenNameException = aws.json.parseJsonObject(errors.InvalidGitHubAccountTokenNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_git_hub_account_token_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidIamSessionArnException")) {
        const parsed_error: ?errors.InvalidIamSessionArnException = aws.json.parseJsonObject(errors.InvalidIamSessionArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_iam_session_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidIamUserArnException")) {
        const parsed_error: ?errors.InvalidIamUserArnException = aws.json.parseJsonObject(errors.InvalidIamUserArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_iam_user_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidIgnoreApplicationStopFailuresValueException")) {
        const parsed_error: ?errors.InvalidIgnoreApplicationStopFailuresValueException = aws.json.parseJsonObject(errors.InvalidIgnoreApplicationStopFailuresValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_ignore_application_stop_failures_value_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        const parsed_error: ?errors.InvalidInputException = aws.json.parseJsonObject(errors.InvalidInputException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceNameException")) {
        const parsed_error: ?errors.InvalidInstanceNameException = aws.json.parseJsonObject(errors.InvalidInstanceNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceStatusException")) {
        const parsed_error: ?errors.InvalidInstanceStatusException = aws.json.parseJsonObject(errors.InvalidInstanceStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceTypeException")) {
        const parsed_error: ?errors.InvalidInstanceTypeException = aws.json.parseJsonObject(errors.InvalidInstanceTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidKeyPrefixFilterException")) {
        const parsed_error: ?errors.InvalidKeyPrefixFilterException = aws.json.parseJsonObject(errors.InvalidKeyPrefixFilterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_key_prefix_filter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLifecycleEventHookExecutionIdException")) {
        const parsed_error: ?errors.InvalidLifecycleEventHookExecutionIdException = aws.json.parseJsonObject(errors.InvalidLifecycleEventHookExecutionIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_lifecycle_event_hook_execution_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLifecycleEventHookExecutionStatusException")) {
        const parsed_error: ?errors.InvalidLifecycleEventHookExecutionStatusException = aws.json.parseJsonObject(errors.InvalidLifecycleEventHookExecutionStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_lifecycle_event_hook_execution_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLoadBalancerInfoException")) {
        const parsed_error: ?errors.InvalidLoadBalancerInfoException = aws.json.parseJsonObject(errors.InvalidLoadBalancerInfoException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_load_balancer_info_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidMinimumHealthyHostValueException")) {
        const parsed_error: ?errors.InvalidMinimumHealthyHostValueException = aws.json.parseJsonObject(errors.InvalidMinimumHealthyHostValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_minimum_healthy_host_value_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?errors.InvalidNextTokenException = aws.json.parseJsonObject(errors.InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOnPremisesTagCombinationException")) {
        const parsed_error: ?errors.InvalidOnPremisesTagCombinationException = aws.json.parseJsonObject(errors.InvalidOnPremisesTagCombinationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_on_premises_tag_combination_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        const parsed_error: ?errors.InvalidOperationException = aws.json.parseJsonObject(errors.InvalidOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRegistrationStatusException")) {
        const parsed_error: ?errors.InvalidRegistrationStatusException = aws.json.parseJsonObject(errors.InvalidRegistrationStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_registration_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRevisionException")) {
        const parsed_error: ?errors.InvalidRevisionException = aws.json.parseJsonObject(errors.InvalidRevisionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_revision_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRoleException")) {
        const parsed_error: ?errors.InvalidRoleException = aws.json.parseJsonObject(errors.InvalidRoleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_role_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSortByException")) {
        const parsed_error: ?errors.InvalidSortByException = aws.json.parseJsonObject(errors.InvalidSortByException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_sort_by_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSortOrderException")) {
        const parsed_error: ?errors.InvalidSortOrderException = aws.json.parseJsonObject(errors.InvalidSortOrderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_sort_order_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        const parsed_error: ?errors.InvalidTagException = aws.json.parseJsonObject(errors.InvalidTagException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagFilterException")) {
        const parsed_error: ?errors.InvalidTagFilterException = aws.json.parseJsonObject(errors.InvalidTagFilterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag_filter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagsToAddException")) {
        const parsed_error: ?errors.InvalidTagsToAddException = aws.json.parseJsonObject(errors.InvalidTagsToAddException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tags_to_add_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetFilterNameException")) {
        const parsed_error: ?errors.InvalidTargetFilterNameException = aws.json.parseJsonObject(errors.InvalidTargetFilterNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target_filter_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetGroupPairException")) {
        const parsed_error: ?errors.InvalidTargetGroupPairException = aws.json.parseJsonObject(errors.InvalidTargetGroupPairException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target_group_pair_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetInstancesException")) {
        const parsed_error: ?errors.InvalidTargetInstancesException = aws.json.parseJsonObject(errors.InvalidTargetInstancesException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target_instances_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTimeRangeException")) {
        const parsed_error: ?errors.InvalidTimeRangeException = aws.json.parseJsonObject(errors.InvalidTimeRangeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_time_range_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTrafficRoutingConfigurationException")) {
        const parsed_error: ?errors.InvalidTrafficRoutingConfigurationException = aws.json.parseJsonObject(errors.InvalidTrafficRoutingConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_traffic_routing_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTriggerConfigException")) {
        const parsed_error: ?errors.InvalidTriggerConfigException = aws.json.parseJsonObject(errors.InvalidTriggerConfigException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_trigger_config_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidUpdateOutdatedInstancesOnlyValueException")) {
        const parsed_error: ?errors.InvalidUpdateOutdatedInstancesOnlyValueException = aws.json.parseJsonObject(errors.InvalidUpdateOutdatedInstancesOnlyValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_update_outdated_instances_only_value_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidZonalDeploymentConfigurationException")) {
        const parsed_error: ?errors.InvalidZonalDeploymentConfigurationException = aws.json.parseJsonObject(errors.InvalidZonalDeploymentConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_zonal_deployment_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LifecycleEventAlreadyCompletedException")) {
        const parsed_error: ?errors.LifecycleEventAlreadyCompletedException = aws.json.parseJsonObject(errors.LifecycleEventAlreadyCompletedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .lifecycle_event_already_completed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LifecycleHookLimitExceededException")) {
        const parsed_error: ?errors.LifecycleHookLimitExceededException = aws.json.parseJsonObject(errors.LifecycleHookLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .lifecycle_hook_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MultipleIamArnsProvidedException")) {
        const parsed_error: ?errors.MultipleIamArnsProvidedException = aws.json.parseJsonObject(errors.MultipleIamArnsProvidedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .multiple_iam_arns_provided_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationNotSupportedException")) {
        const parsed_error: ?errors.OperationNotSupportedException = aws.json.parseJsonObject(errors.OperationNotSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_not_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceArnRequiredException")) {
        const parsed_error: ?errors.ResourceArnRequiredException = aws.json.parseJsonObject(errors.ResourceArnRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_arn_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceValidationException")) {
        const parsed_error: ?errors.ResourceValidationException = aws.json.parseJsonObject(errors.ResourceValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_validation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RevisionDoesNotExistException")) {
        const parsed_error: ?errors.RevisionDoesNotExistException = aws.json.parseJsonObject(errors.RevisionDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .revision_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RevisionRequiredException")) {
        const parsed_error: ?errors.RevisionRequiredException = aws.json.parseJsonObject(errors.RevisionRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .revision_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RoleRequiredException")) {
        const parsed_error: ?errors.RoleRequiredException = aws.json.parseJsonObject(errors.RoleRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .role_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        const parsed_error: ?errors.TagLimitExceededException = aws.json.parseJsonObject(errors.TagLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagRequiredException")) {
        const parsed_error: ?errors.TagRequiredException = aws.json.parseJsonObject(errors.TagRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagSetListLimitExceededException")) {
        const parsed_error: ?errors.TagSetListLimitExceededException = aws.json.parseJsonObject(errors.TagSetListLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_set_list_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TriggerTargetsLimitExceededException")) {
        const parsed_error: ?errors.TriggerTargetsLimitExceededException = aws.json.parseJsonObject(errors.TriggerTargetsLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .trigger_targets_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedActionForDeploymentTypeException")) {
        const parsed_error: ?errors.UnsupportedActionForDeploymentTypeException = aws.json.parseJsonObject(errors.UnsupportedActionForDeploymentTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_action_for_deployment_type_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
