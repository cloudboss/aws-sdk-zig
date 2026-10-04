const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ThingTypeProperties = @import("thing_type_properties.zig").ThingTypeProperties;

pub const CreateThingTypeInput = struct {
    /// Metadata which can be used to manage the thing type.
    tags: ?[]const Tag = null,

    /// The name of the thing type.
    thing_type_name: []const u8,

    /// The ThingTypeProperties for the thing type to create. It contains
    /// information about
    /// the new thing type including a description, and a list of searchable thing
    /// attribute
    /// names.
    thing_type_properties: ?ThingTypeProperties = null,

    pub const json_field_names = .{
        .tags = "tags",
        .thing_type_name = "thingTypeName",
        .thing_type_properties = "thingTypeProperties",
    };
};

pub const CreateThingTypeOutput = struct {
    /// The Amazon Resource Name (ARN) of the thing type.
    thing_type_arn: ?[]const u8 = null,

    /// The thing type ID.
    thing_type_id: ?[]const u8 = null,

    /// The name of the thing type.
    thing_type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .thing_type_arn = "thingTypeArn",
        .thing_type_id = "thingTypeId",
        .thing_type_name = "thingTypeName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateThingTypeInput, options: CallOptions) !CreateThingTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateThingTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/thing-types/");
    try path_buf.appendSlice(allocator, input.thing_type_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.thing_type_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"thingTypeProperties\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateThingTypeOutput {
    const result: CreateThingTypeOutput = try aws.json.parseJsonObject(
        CreateThingTypeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
