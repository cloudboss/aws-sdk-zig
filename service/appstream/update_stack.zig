const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AccessEndpoint = @import("access_endpoint.zig").AccessEndpoint;
const ApplicationSettings = @import("application_settings.zig").ApplicationSettings;
const StackAttribute = @import("stack_attribute.zig").StackAttribute;
const StorageConnector = @import("storage_connector.zig").StorageConnector;
const StreamingExperienceSettings = @import("streaming_experience_settings.zig").StreamingExperienceSettings;
const UserSetting = @import("user_setting.zig").UserSetting;
const Stack = @import("stack.zig").Stack;

pub const UpdateStackInput = struct {
    /// The list of interface VPC endpoint (interface endpoint) objects. Users of
    /// the stack can connect to WorkSpaces Applications only through the specified
    /// endpoints.
    access_endpoints: ?[]const AccessEndpoint = null,

    /// The persistent application settings for users of a stack. When these
    /// settings are enabled, changes that users make to applications and Windows
    /// settings are automatically saved after each session and applied to the next
    /// session.
    application_settings: ?ApplicationSettings = null,

    /// The stack attributes to delete.
    attributes_to_delete: ?[]const StackAttribute = null,

    /// Deletes the storage connectors currently enabled for the stack.
    delete_storage_connectors: ?bool = null,

    /// The description to display.
    description: ?[]const u8 = null,

    /// The stack name to display.
    display_name: ?[]const u8 = null,

    /// The domains where WorkSpaces Applications streaming sessions can be embedded
    /// in an iframe. You must approve the domains that you want to host embedded
    /// WorkSpaces Applications streaming sessions.
    embed_host_domains: ?[]const []const u8 = null,

    /// The URL that users are redirected to after they choose the Send Feedback
    /// link. If no URL is specified, no Send Feedback link is displayed.
    feedback_url: ?[]const u8 = null,

    /// The name of the stack.
    name: []const u8,

    /// The URL that users are redirected to after their streaming session ends.
    redirect_url: ?[]const u8 = null,

    /// The storage connectors to enable.
    storage_connectors: ?[]const StorageConnector = null,

    /// The streaming protocol you want your stack to prefer. This can be UDP or
    /// TCP. Currently, UDP is only supported in the Windows native client.
    streaming_experience_settings: ?StreamingExperienceSettings = null,

    /// The actions that are enabled or disabled for users during their streaming
    /// sessions. By default, these actions are enabled.
    user_settings: ?[]const UserSetting = null,

    pub const json_field_names = .{
        .access_endpoints = "AccessEndpoints",
        .application_settings = "ApplicationSettings",
        .attributes_to_delete = "AttributesToDelete",
        .delete_storage_connectors = "DeleteStorageConnectors",
        .description = "Description",
        .display_name = "DisplayName",
        .embed_host_domains = "EmbedHostDomains",
        .feedback_url = "FeedbackURL",
        .name = "Name",
        .redirect_url = "RedirectURL",
        .storage_connectors = "StorageConnectors",
        .streaming_experience_settings = "StreamingExperienceSettings",
        .user_settings = "UserSettings",
    };
};

pub const UpdateStackOutput = struct {
    /// Information about the stack.
    stack: ?Stack = null,

    pub const json_field_names = .{
        .stack = "Stack",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStackInput, options: Options) !UpdateStackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appstream");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream", "AppStream", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.UpdateStack");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStackOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateStackOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DryRunOperationException")) {
        return .{ .arena = arena, .kind = .{ .dry_run_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntitlementAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .entitlement_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntitlementNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .entitlement_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleImageException")) {
        return .{ .arena = arena, .kind = .{ .incompatible_image_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAccountStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_account_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRoleException")) {
        return .{ .arena = arena, .kind = .{ .invalid_role_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .request_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotAvailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_available_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
