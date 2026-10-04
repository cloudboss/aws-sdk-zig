const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateSceneInput = struct {
    /// A list of capabilities that the scene uses to render itself.
    capabilities: ?[]const []const u8 = null,

    /// The relative path that specifies the location of the content definition
    /// file.
    content_location: []const u8,

    /// The description for this scene.
    description: ?[]const u8 = null,

    /// The ID of the scene.
    scene_id: []const u8,

    /// The request metadata.
    scene_metadata: ?[]const aws.map.StringMapEntry = null,

    /// Metadata that you can use to manage the scene.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the workspace that contains the scene.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .content_location = "contentLocation",
        .description = "description",
        .scene_id = "sceneId",
        .scene_metadata = "sceneMetadata",
        .tags = "tags",
        .workspace_id = "workspaceId",
    };
};

pub const CreateSceneOutput = struct {
    /// The ARN of the scene.
    arn: []const u8,

    /// The date and time when the scene was created.
    creation_date_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSceneInput, options: CallOptions) !CreateSceneOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSceneInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/scenes");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.capabilities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"capabilities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"contentLocation\":");
    try aws.json.writeValue(@TypeOf(input.content_location), input.content_location, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sceneId\":");
    try aws.json.writeValue(@TypeOf(input.scene_id), input.scene_id, allocator, &body_buf);
    has_prev = true;
    if (input.scene_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sceneMetadata\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSceneOutput {
    var result: CreateSceneOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSceneOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
