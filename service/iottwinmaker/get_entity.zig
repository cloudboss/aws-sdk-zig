const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComponentResponse = @import("component_response.zig").ComponentResponse;
const Status = @import("status.zig").Status;

pub const GetEntityInput = struct {
    /// The ID of the entity.
    entity_id: []const u8,

    /// The ID of the workspace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .entity_id = "entityId",
        .workspace_id = "workspaceId",
    };
};

pub const GetEntityOutput = struct {
    /// This flag notes whether all components are returned in the API response. The
    /// maximum number of components returned is 30.
    are_all_components_returned: ?bool = null,

    /// The ARN of the entity.
    arn: []const u8,

    /// An object that maps strings to the components in the entity. Each string in
    /// the mapping
    /// must be unique to this object.
    components: ?[]const aws.map.MapEntry(ComponentResponse) = null,

    /// The date and time when the entity was created.
    creation_date_time: i64,

    /// The description of the entity.
    description: ?[]const u8 = null,

    /// The ID of the entity.
    entity_id: []const u8,

    /// The name of the entity.
    entity_name: []const u8,

    /// A Boolean value that specifies whether the entity has associated child
    /// entities.
    has_child_entities: bool,

    /// The ID of the parent entity for this entity.
    parent_entity_id: []const u8,

    /// The current status of the entity.
    status: ?Status = null,

    /// The syncSource of the sync job, if this entity was created by a sync job.
    sync_source: ?[]const u8 = null,

    /// The date and time when the entity was last updated.
    update_date_time: i64,

    /// The ID of the workspace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .are_all_components_returned = "areAllComponentsReturned",
        .arn = "arn",
        .components = "components",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .entity_id = "entityId",
        .entity_name = "entityName",
        .has_child_entities = "hasChildEntities",
        .parent_entity_id = "parentEntityId",
        .status = "status",
        .sync_source = "syncSource",
        .update_date_time = "updateDateTime",
        .workspace_id = "workspaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEntityInput, options: CallOptions) !GetEntityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEntityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/entities/");
    try path_buf.appendSlice(allocator, input.entity_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEntityOutput {
    var result: GetEntityOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEntityOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
