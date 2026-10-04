const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributePayload = @import("attribute_payload.zig").AttributePayload;

pub const UpdateThingInput = struct {
    /// A list of thing attributes, a JSON string containing name-value pairs. For
    /// example:
    ///
    /// `{\"attributes\":{\"name1\":\"value2\"}}`
    ///
    /// This data is used to add new attributes or update existing attributes.
    attribute_payload: ?AttributePayload = null,

    /// The expected version of the thing record in the registry. If the version of
    /// the
    /// record in the registry does not match the expected version specified in the
    /// request, the
    /// `UpdateThing` request is rejected with a
    /// `VersionConflictException`.
    expected_version: ?i64 = null,

    /// Remove a thing type association. If **true**, the
    /// association is removed.
    remove_thing_type: ?bool = null,

    /// The name of the thing to update.
    ///
    /// You can't change a thing's name. To change a thing's name, you must create a
    /// new thing, give it the new name, and then delete the old thing.
    thing_name: []const u8,

    /// The name of the thing type.
    thing_type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_payload = "attributePayload",
        .expected_version = "expectedVersion",
        .remove_thing_type = "removeThingType",
        .thing_name = "thingName",
        .thing_type_name = "thingTypeName",
    };
};

pub const UpdateThingOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateThingInput, options: CallOptions) !UpdateThingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateThingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attribute_payload) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attributePayload\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.expected_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"expectedVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remove_thing_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"removeThingType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.thing_type_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"thingTypeName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateThingOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateThingOutput = .{};

    return result;
}
