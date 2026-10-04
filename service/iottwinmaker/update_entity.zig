const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComponentUpdateRequest = @import("component_update_request.zig").ComponentUpdateRequest;
const CompositeComponentUpdateRequest = @import("composite_component_update_request.zig").CompositeComponentUpdateRequest;
const ParentEntityUpdateRequest = @import("parent_entity_update_request.zig").ParentEntityUpdateRequest;
const State = @import("state.zig").State;

pub const UpdateEntityInput = struct {
    /// An object that maps strings to the component updates in the request. Each
    /// string in the
    /// mapping must be unique to this object.
    component_updates: ?[]const aws.map.MapEntry(ComponentUpdateRequest) = null,

    /// This is an object that maps strings to `compositeComponent` updates in the
    /// request. Each key
    /// of the map represents the `componentPath` of the `compositeComponent`.
    composite_component_updates: ?[]const aws.map.MapEntry(CompositeComponentUpdateRequest) = null,

    /// The description of the entity.
    description: ?[]const u8 = null,

    /// The ID of the entity.
    entity_id: []const u8,

    /// The name of the entity.
    entity_name: ?[]const u8 = null,

    /// An object that describes the update request for a parent entity.
    parent_entity_update: ?ParentEntityUpdateRequest = null,

    /// The ID of the workspace that contains the entity.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .component_updates = "componentUpdates",
        .composite_component_updates = "compositeComponentUpdates",
        .description = "description",
        .entity_id = "entityId",
        .entity_name = "entityName",
        .parent_entity_update = "parentEntityUpdate",
        .workspace_id = "workspaceId",
    };
};

pub const UpdateEntityOutput = struct {
    /// The current state of the entity update.
    state: State,

    /// The date and time when the entity was last updated.
    update_date_time: i64,

    pub const json_field_names = .{
        .state = "state",
        .update_date_time = "updateDateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEntityInput, options: CallOptions) !UpdateEntityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEntityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/entities/");
    try path_buf.appendSlice(allocator, input.entity_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.component_updates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"componentUpdates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.composite_component_updates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"compositeComponentUpdates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.entity_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"entityName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_entity_update) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parentEntityUpdate\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEntityOutput {
    var result: UpdateEntityOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateEntityOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
