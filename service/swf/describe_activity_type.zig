const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const ActivityType = @import("activity_type.zig").ActivityType;
const ActivityTypeConfiguration = @import("activity_type_configuration.zig").ActivityTypeConfiguration;
const ActivityTypeInfo = @import("activity_type_info.zig").ActivityTypeInfo;

pub const DescribeActivityTypeInput = struct {
    /// The activity type to get information about. Activity types are identified by
    /// the
    /// `name` and `version` that were supplied when the activity was
    /// registered.
    activity_type: ActivityType,

    /// The name of the domain in which the activity type is registered.
    domain: []const u8,

    pub const json_field_names = .{
        .activity_type = "activityType",
        .domain = "domain",
    };
};

pub const DescribeActivityTypeOutput = struct {
    /// The configuration settings registered with the activity type.
    configuration: ?ActivityTypeConfiguration = null,

    /// General information about the activity type.
    ///
    /// The status of activity type (returned in the ActivityTypeInfo structure) can
    /// be one of the following.
    ///
    /// * `REGISTERED` – The type is registered and available. Workers supporting
    ///   this
    /// type should be running.
    ///
    /// * `DEPRECATED` – The type was deprecated using DeprecateActivityType, but is
    /// still in use. You should keep workers supporting this type running.
    /// You cannot create new tasks of this type.
    type_info: ?ActivityTypeInfo = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .type_info = "typeInfo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeActivityTypeInput, options: CallOptions) !DescribeActivityTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "swf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeActivityTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.DescribeActivityType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeActivityTypeOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeActivityTypeOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "DefaultUndefinedFault")) {
        const parsed_error: ?errors.DefaultUndefinedFault = aws.json.parseJsonObject(errors.DefaultUndefinedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .default_undefined_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DomainAlreadyExistsFault")) {
        const parsed_error: ?errors.DomainAlreadyExistsFault = aws.json.parseJsonObject(errors.DomainAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .domain_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DomainDeprecatedFault")) {
        const parsed_error: ?errors.DomainDeprecatedFault = aws.json.parseJsonObject(errors.DomainDeprecatedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .domain_deprecated_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        const parsed_error: ?errors.LimitExceededFault = aws.json.parseJsonObject(errors.LimitExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedFault")) {
        const parsed_error: ?errors.OperationNotPermittedFault = aws.json.parseJsonObject(errors.OperationNotPermittedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_not_permitted_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsFault")) {
        const parsed_error: ?errors.TooManyTagsFault = aws.json.parseJsonObject(errors.TooManyTagsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TypeAlreadyExistsFault")) {
        const parsed_error: ?errors.TypeAlreadyExistsFault = aws.json.parseJsonObject(errors.TypeAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .type_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TypeDeprecatedFault")) {
        const parsed_error: ?errors.TypeDeprecatedFault = aws.json.parseJsonObject(errors.TypeDeprecatedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .type_deprecated_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TypeNotDeprecatedFault")) {
        const parsed_error: ?errors.TypeNotDeprecatedFault = aws.json.parseJsonObject(errors.TypeNotDeprecatedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .type_not_deprecated_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnknownResourceFault")) {
        const parsed_error: ?errors.UnknownResourceFault = aws.json.parseJsonObject(errors.UnknownResourceFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unknown_resource_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WorkflowExecutionAlreadyStartedFault")) {
        const parsed_error: ?errors.WorkflowExecutionAlreadyStartedFault = aws.json.parseJsonObject(errors.WorkflowExecutionAlreadyStartedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .workflow_execution_already_started_fault = typed_error } };
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
