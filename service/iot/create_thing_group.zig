const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ThingGroupProperties = @import("thing_group_properties.zig").ThingGroupProperties;

pub const CreateThingGroupInput = struct {
    /// The name of the parent thing group.
    parent_group_name: ?[]const u8 = null,

    /// Metadata which can be used to manage the thing group.
    tags: ?[]const Tag = null,

    /// The thing group name to create.
    thing_group_name: []const u8,

    /// The thing group properties.
    thing_group_properties: ?ThingGroupProperties = null,

    pub const json_field_names = .{
        .parent_group_name = "parentGroupName",
        .tags = "tags",
        .thing_group_name = "thingGroupName",
        .thing_group_properties = "thingGroupProperties",
    };
};

pub const CreateThingGroupOutput = struct {
    /// The thing group ARN.
    thing_group_arn: ?[]const u8 = null,

    /// The thing group ID.
    thing_group_id: ?[]const u8 = null,

    /// The thing group name.
    thing_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .thing_group_arn = "thingGroupArn",
        .thing_group_id = "thingGroupId",
        .thing_group_name = "thingGroupName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateThingGroupInput, options: CallOptions) !CreateThingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateThingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/thing-groups/");
    try path_buf.appendSlice(allocator, input.thing_group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.parent_group_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parentGroupName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.thing_group_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"thingGroupProperties\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateThingGroupOutput {
    var result: CreateThingGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateThingGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
