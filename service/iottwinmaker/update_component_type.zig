const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CompositeComponentTypeRequest = @import("composite_component_type_request.zig").CompositeComponentTypeRequest;
const FunctionRequest = @import("function_request.zig").FunctionRequest;
const PropertyDefinitionRequest = @import("property_definition_request.zig").PropertyDefinitionRequest;
const PropertyGroupRequest = @import("property_group_request.zig").PropertyGroupRequest;
const State = @import("state.zig").State;

pub const UpdateComponentTypeInput = struct {
    /// The ID of the component type.
    component_type_id: []const u8,

    /// The component type name.
    component_type_name: ?[]const u8 = null,

    /// This is an object that maps strings to `compositeComponentTypes` of the
    /// `componentType`.
    /// `CompositeComponentType` is referenced by `componentTypeId`.
    composite_component_types: ?[]const aws.map.MapEntry(CompositeComponentTypeRequest) = null,

    /// The description of the component type.
    description: ?[]const u8 = null,

    /// Specifies the component type that this component type extends.
    extends_from: ?[]const []const u8 = null,

    /// An object that maps strings to the functions in the component type. Each
    /// string in the
    /// mapping must be unique to this object.
    functions: ?[]const aws.map.MapEntry(FunctionRequest) = null,

    /// A Boolean value that specifies whether an entity can have more than one
    /// component of
    /// this type.
    is_singleton: ?bool = null,

    /// An object that maps strings to the property definitions in the component
    /// type. Each
    /// string in the mapping must be unique to this object.
    property_definitions: ?[]const aws.map.MapEntry(PropertyDefinitionRequest) = null,

    /// The property groups.
    property_groups: ?[]const aws.map.MapEntry(PropertyGroupRequest) = null,

    /// The ID of the workspace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .component_type_id = "componentTypeId",
        .component_type_name = "componentTypeName",
        .composite_component_types = "compositeComponentTypes",
        .description = "description",
        .extends_from = "extendsFrom",
        .functions = "functions",
        .is_singleton = "isSingleton",
        .property_definitions = "propertyDefinitions",
        .property_groups = "propertyGroups",
        .workspace_id = "workspaceId",
    };
};

pub const UpdateComponentTypeOutput = struct {
    /// The ARN of the component type.
    arn: []const u8,

    /// The ID of the component type.
    component_type_id: []const u8,

    /// The current state of the component type.
    state: State,

    /// The ID of the workspace that contains the component type.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .component_type_id = "componentTypeId",
        .state = "state",
        .workspace_id = "workspaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateComponentTypeInput, options: CallOptions) !UpdateComponentTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateComponentTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/component-types/");
    try path_buf.appendSlice(allocator, input.component_type_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.component_type_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"componentTypeName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.composite_component_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"compositeComponentTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.extends_from) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"extendsFrom\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.functions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"functions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.is_singleton) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"isSingleton\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.property_definitions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"propertyDefinitions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.property_groups) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"propertyGroups\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateComponentTypeOutput {
    const result: UpdateComponentTypeOutput = try aws.json.parseJsonObject(
        UpdateComponentTypeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
