const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateThingGroupsForThingInput = struct {
    /// Override dynamic thing groups with static thing groups when 10-group limit
    /// is
    /// reached. If a thing belongs to 10 thing groups, and one or more of those
    /// groups are
    /// dynamic thing groups, adding a thing to a static group removes the thing
    /// from the last
    /// dynamic group.
    override_dynamic_groups: ?bool = null,

    /// The groups to which the thing will be added.
    thing_groups_to_add: ?[]const []const u8 = null,

    /// The groups from which the thing will be removed.
    thing_groups_to_remove: ?[]const []const u8 = null,

    /// The thing whose group memberships will be updated.
    thing_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .override_dynamic_groups = "overrideDynamicGroups",
        .thing_groups_to_add = "thingGroupsToAdd",
        .thing_groups_to_remove = "thingGroupsToRemove",
        .thing_name = "thingName",
    };
};

pub const UpdateThingGroupsForThingOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateThingGroupsForThingInput, options: CallOptions) !UpdateThingGroupsForThingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateThingGroupsForThingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/thing-groups/updateThingGroupsForThing";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.override_dynamic_groups) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"overrideDynamicGroups\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.thing_groups_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"thingGroupsToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.thing_groups_to_remove) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"thingGroupsToRemove\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.thing_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"thingName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateThingGroupsForThingOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateThingGroupsForThingOutput = .{};

    return result;
}
