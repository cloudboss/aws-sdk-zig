const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CompositeComponentTypeResponse = @import("composite_component_type_response.zig").CompositeComponentTypeResponse;
const FunctionResponse = @import("function_response.zig").FunctionResponse;
const PropertyDefinitionResponse = @import("property_definition_response.zig").PropertyDefinitionResponse;
const PropertyGroupResponse = @import("property_group_response.zig").PropertyGroupResponse;
const Status = @import("status.zig").Status;

pub const GetComponentTypeInput = struct {
    /// The ID of the component type.
    component_type_id: []const u8,

    /// The ID of the workspace that contains the component type.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .component_type_id = "componentTypeId",
        .workspace_id = "workspaceId",
    };
};

pub const GetComponentTypeOutput = struct {
    /// The ARN of the component type.
    arn: []const u8,

    /// The ID of the component type.
    component_type_id: []const u8,

    /// The component type name.
    component_type_name: ?[]const u8 = null,

    /// This is an object that maps strings to `compositeComponentTypes` of the
    /// `componentType`. `CompositeComponentType` is referenced by
    /// `componentTypeId`.
    composite_component_types: ?[]const aws.map.MapEntry(CompositeComponentTypeResponse) = null,

    /// The date and time when the component type was created.
    creation_date_time: i64,

    /// The description of the component type.
    description: ?[]const u8 = null,

    /// The name of the parent component type that this component type extends.
    extends_from: ?[]const []const u8 = null,

    /// An object that maps strings to the functions in the component type. Each
    /// string in the
    /// mapping must be unique to this object.
    functions: ?[]const aws.map.MapEntry(FunctionResponse) = null,

    /// A Boolean value that specifies whether the component type is abstract.
    is_abstract: ?bool = null,

    /// A Boolean value that specifies whether the component type has a schema
    /// initializer and
    /// that the schema initializer has run.
    is_schema_initialized: ?bool = null,

    /// A Boolean value that specifies whether an entity can have more than one
    /// component of
    /// this type.
    is_singleton: ?bool = null,

    /// An object that maps strings to the property definitions in the component
    /// type. Each
    /// string in the mapping must be unique to this object.
    property_definitions: ?[]const aws.map.MapEntry(PropertyDefinitionResponse) = null,

    /// The maximum number of results to return at one time. The default is 25.
    ///
    /// Valid Range: Minimum value of 1. Maximum value of 250.
    property_groups: ?[]const aws.map.MapEntry(PropertyGroupResponse) = null,

    /// The current status of the component type.
    status: ?Status = null,

    /// The syncSource of the SyncJob, if this entity was created by a SyncJob.
    sync_source: ?[]const u8 = null,

    /// The date and time when the component was last updated.
    update_date_time: i64,

    /// The ID of the workspace that contains the component type.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .component_type_id = "componentTypeId",
        .component_type_name = "componentTypeName",
        .composite_component_types = "compositeComponentTypes",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .extends_from = "extendsFrom",
        .functions = "functions",
        .is_abstract = "isAbstract",
        .is_schema_initialized = "isSchemaInitialized",
        .is_singleton = "isSingleton",
        .property_definitions = "propertyDefinitions",
        .property_groups = "propertyGroups",
        .status = "status",
        .sync_source = "syncSource",
        .update_date_time = "updateDateTime",
        .workspace_id = "workspaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetComponentTypeInput, options: CallOptions) !GetComponentTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iottwinmaker");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetComponentTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/component-types/");
    try path_buf.appendSlice(allocator, input.component_type_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetComponentTypeOutput {
    var result: GetComponentTypeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetComponentTypeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

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
    if (std.mem.eql(u8, error_code, "ConnectorFailureException")) {
        return .{ .arena = arena, .kind = .{ .connector_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConnectorTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .connector_timeout_exception = .{
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
    if (std.mem.eql(u8, error_code, "QueryTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .query_timeout_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
