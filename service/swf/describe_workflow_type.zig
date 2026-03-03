const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const WorkflowType = @import("workflow_type.zig").WorkflowType;
const WorkflowTypeConfiguration = @import("workflow_type_configuration.zig").WorkflowTypeConfiguration;
const WorkflowTypeInfo = @import("workflow_type_info.zig").WorkflowTypeInfo;

pub const DescribeWorkflowTypeInput = struct {
    /// The name of the domain in which this workflow type is registered.
    domain: []const u8,

    /// The workflow type to describe.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .domain = "domain",
        .workflow_type = "workflowType",
    };
};

pub const DescribeWorkflowTypeOutput = struct {
    /// Configuration settings of the workflow type registered through
    /// RegisterWorkflowType
    configuration: ?WorkflowTypeConfiguration = null,

    /// General information about the workflow type.
    ///
    /// The status of the workflow type (returned in the WorkflowTypeInfo structure)
    /// can be one of the following.
    ///
    /// * `REGISTERED` – The type is registered and available. Workers supporting
    ///   this type should be running.
    ///
    /// * `DEPRECATED` – The type was deprecated using DeprecateWorkflowType, but is
    ///   still in use. You should
    /// keep workers supporting this type running. You cannot create new workflow
    /// executions of this type.
    type_info: ?WorkflowTypeInfo = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .type_info = "typeInfo",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWorkflowTypeInput, options: Options) !DescribeWorkflowTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "swf");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWorkflowTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.DescribeWorkflowType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWorkflowTypeOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeWorkflowTypeOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "DefaultUndefinedFault")) {
        return .{ .arena = arena, .kind = .{ .default_undefined_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .domain_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainDeprecatedFault")) {
        return .{ .arena = arena, .kind = .{ .domain_deprecated_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedFault")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsFault")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .type_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeDeprecatedFault")) {
        return .{ .arena = arena, .kind = .{ .type_deprecated_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeNotDeprecatedFault")) {
        return .{ .arena = arena, .kind = .{ .type_not_deprecated_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownResourceFault")) {
        return .{ .arena = arena, .kind = .{ .unknown_resource_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WorkflowExecutionAlreadyStartedFault")) {
        return .{ .arena = arena, .kind = .{ .workflow_execution_already_started_fault = .{
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
