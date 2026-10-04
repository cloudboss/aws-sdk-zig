const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThingGroupProperties = @import("thing_group_properties.zig").ThingGroupProperties;

pub const UpdateDynamicThingGroupInput = struct {
    /// The expected version of the dynamic thing group to update.
    expected_version: ?i64 = null,

    /// The dynamic thing group index to update.
    ///
    /// Currently one index is supported: `AWS_Things`.
    index_name: ?[]const u8 = null,

    /// The dynamic thing group search query string to update.
    query_string: ?[]const u8 = null,

    /// The dynamic thing group query version to update.
    ///
    /// Currently one query version is supported: "2017-09-30". If not specified,
    /// the
    /// query version defaults to this value.
    query_version: ?[]const u8 = null,

    /// The name of the dynamic thing group to update.
    thing_group_name: []const u8,

    /// The dynamic thing group properties to update.
    thing_group_properties: ThingGroupProperties,

    pub const json_field_names = .{
        .expected_version = "expectedVersion",
        .index_name = "indexName",
        .query_string = "queryString",
        .query_version = "queryVersion",
        .thing_group_name = "thingGroupName",
        .thing_group_properties = "thingGroupProperties",
    };
};

pub const UpdateDynamicThingGroupOutput = struct {
    /// The dynamic thing group version.
    version: ?i64 = null,

    pub const json_field_names = .{
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDynamicThingGroupInput, options: CallOptions) !UpdateDynamicThingGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDynamicThingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/dynamic-thing-groups/");
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
    if (input.index_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"indexName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.query_string) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queryString\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.query_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queryVersion\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDynamicThingGroupOutput {
    const result: UpdateDynamicThingGroupOutput = try aws.json.parseJsonObject(
        UpdateDynamicThingGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
