const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComponentRequest = @import("component_request.zig").ComponentRequest;
const CompositeComponentRequest = @import("composite_component_request.zig").CompositeComponentRequest;
const State = @import("state.zig").State;

pub const CreateEntityInput = struct {
    /// An object that maps strings to the components in the entity. Each string in
    /// the mapping
    /// must be unique to this object.
    components: ?[]const aws.map.MapEntry(ComponentRequest) = null,

    /// This is an object that maps strings to `compositeComponent` updates in the
    /// request.
    /// Each key of the map represents the `componentPath` of the
    /// `compositeComponent`.
    composite_components: ?[]const aws.map.MapEntry(CompositeComponentRequest) = null,

    /// The description of the entity.
    description: ?[]const u8 = null,

    /// The ID of the entity.
    entity_id: ?[]const u8 = null,

    /// The name of the entity.
    entity_name: []const u8,

    /// The ID of the entity's parent entity.
    parent_entity_id: ?[]const u8 = null,

    /// Metadata that you can use to manage the entity.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the workspace that contains the entity.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .components = "components",
        .composite_components = "compositeComponents",
        .description = "description",
        .entity_id = "entityId",
        .entity_name = "entityName",
        .parent_entity_id = "parentEntityId",
        .tags = "tags",
        .workspace_id = "workspaceId",
    };
};

pub const CreateEntityOutput = struct {
    /// The ARN of the entity.
    arn: []const u8,

    /// The date and time when the entity was created.
    creation_date_time: i64,

    /// The ID of the entity.
    entity_id: []const u8,

    /// The current state of the entity.
    state: State,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .entity_id = "entityId",
        .state = "state",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEntityInput, options: CallOptions) !CreateEntityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEntityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/entities");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.components) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"components\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.composite_components) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"compositeComponents\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.entity_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"entityId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"entityName\":");
    try aws.json.writeValue(@TypeOf(input.entity_name), input.entity_name, allocator, &body_buf);
    has_prev = true;
    if (input.parent_entity_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parentEntityId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEntityOutput {
    const result: CreateEntityOutput = try aws.json.parseJsonObject(
        CreateEntityOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
