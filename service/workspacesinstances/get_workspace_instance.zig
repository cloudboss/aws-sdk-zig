const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BillingConfiguration = @import("billing_configuration.zig").BillingConfiguration;
const EC2InstanceError = @import("ec2_instance_error.zig").EC2InstanceError;
const EC2ManagedInstance = @import("ec2_managed_instance.zig").EC2ManagedInstance;
const ProvisionStateEnum = @import("provision_state_enum.zig").ProvisionStateEnum;
const WorkspaceInstanceError = @import("workspace_instance_error.zig").WorkspaceInstanceError;

pub const GetWorkspaceInstanceInput = struct {
    /// Unique identifier of the WorkSpace Instance to retrieve.
    workspace_instance_id: []const u8,

    pub const json_field_names = .{
        .workspace_instance_id = "WorkspaceInstanceId",
    };
};

pub const GetWorkspaceInstanceOutput = struct {
    /// Returns the current billing configuration for the WorkSpace Instance,
    /// indicating the active billing mode.
    billing_configuration: ?BillingConfiguration = null,

    /// Includes any underlying EC2 instance errors encountered.
    ec2_instance_errors: ?[]const EC2InstanceError = null,

    /// Details of the associated EC2 managed instance.
    ec2_managed_instance: ?EC2ManagedInstance = null,

    /// Current provisioning state of the WorkSpaces Instance.
    provision_state: ?ProvisionStateEnum = null,

    /// Captures any errors specific to the WorkSpace Instance lifecycle.
    workspace_instance_errors: ?[]const WorkspaceInstanceError = null,

    /// Unique identifier of the retrieved WorkSpaces Instance.
    workspace_instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_configuration = "BillingConfiguration",
        .ec2_instance_errors = "EC2InstanceErrors",
        .ec2_managed_instance = "EC2ManagedInstance",
        .provision_state = "ProvisionState",
        .workspace_instance_errors = "WorkspaceInstanceErrors",
        .workspace_instance_id = "WorkspaceInstanceId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkspaceInstanceInput, options: Options) !GetWorkspaceInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "workspacesinstances");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetWorkspaceInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspacesinstances", "Workspaces Instances", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "EUCMIFrontendAPIService.GetWorkspaceInstance");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetWorkspaceInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetWorkspaceInstanceOutput, body, alloc);
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
