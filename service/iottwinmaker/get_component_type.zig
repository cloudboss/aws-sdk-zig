const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsiottwinmaker", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetComponentTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/component-types/");
    try path_buf.appendSlice(allocator, input.component_type_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetComponentTypeOutput {
    const result: GetComponentTypeOutput = try aws.json.parseJsonObject(
        GetComponentTypeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
