const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateLimitInput = struct {
    /// The new description of the limit.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    description: ?[]const u8 = null,

    /// The new display name of the limit.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the farm that contains the limit.
    farm_id: []const u8,

    /// The unique identifier of the limit to update.
    limit_id: []const u8,

    /// The maximum number of resources constrained by this limit. When all of the
    /// resources are in use, steps that require the limit won't be scheduled until
    /// the resource is available.
    ///
    /// If more than the new maximum number is currently in use, running jobs finish
    /// but no new jobs are started until the number of resources in use is below
    /// the new maximum number.
    ///
    /// The `maxCount` must not be 0. If the value is -1, there is no restriction on
    /// the number of resources that can be acquired for this limit.
    max_count: ?i32 = null,

    pub const json_field_names = .{
        .description = "description",
        .display_name = "displayName",
        .farm_id = "farmId",
        .limit_id = "limitId",
        .max_count = "maxCount",
    };
};

pub const UpdateLimitOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLimitInput, options: CallOptions) !UpdateLimitOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLimitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/limits/");
    try path_buf.appendSlice(allocator, input.limit_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_count) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxCount\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLimitOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateLimitOutput = .{};

    return result;
}
