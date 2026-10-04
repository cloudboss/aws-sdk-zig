const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThingGroupProperties = @import("thing_group_properties.zig").ThingGroupProperties;

pub const UpdateThingGroupInput = struct {
    /// The expected version of the thing group. If this does not match the version
    /// of the
    /// thing group being updated, the update will fail.
    expected_version: ?i64 = null,

    /// The thing group to update.
    thing_group_name: []const u8,

    /// The thing group properties.
    thing_group_properties: ThingGroupProperties,

    pub const json_field_names = .{
        .expected_version = "expectedVersion",
        .thing_group_name = "thingGroupName",
        .thing_group_properties = "thingGroupProperties",
    };
};

pub const UpdateThingGroupOutput = struct {
    /// The version of the updated thing group.
    version: ?i64 = null,

    pub const json_field_names = .{
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateThingGroupInput, options: CallOptions) !UpdateThingGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateThingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/thing-groups/");
    try path_buf.appendSlice(allocator, input.thing_group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.expected_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"expectedVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"thingGroupProperties\":");
    try aws.json.writeValue(@TypeOf(input.thing_group_properties), input.thing_group_properties, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateThingGroupOutput {
    var result: UpdateThingGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateThingGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
