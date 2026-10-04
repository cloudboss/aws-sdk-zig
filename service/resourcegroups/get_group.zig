const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Group = @import("group.zig").Group;

pub const GetGroupInput = struct {
    /// The name or the Amazon resource name (ARN) of the resource group to
    /// retrieve.
    group: ?[]const u8 = null,

    /// Deprecated - don't use this parameter. Use `Group` instead.
    group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .group = "Group",
        .group_name = "GroupName",
    };
};

pub const GetGroupOutput = struct {
    /// A structure that contains the metadata details for the specified resource
    /// group. Use
    /// GetGroupQuery and GetGroupConfiguration to get
    /// those additional details of the resource group.
    group: ?Group = null,

    pub const json_field_names = .{
        .group = "Group",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGroupInput, options: CallOptions) !GetGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-groups", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-groups", "Resource Groups", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-group";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.group) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Group\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.group_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GroupName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGroupOutput {
    const result: GetGroupOutput = try aws.json.parseJsonObject(
        GetGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
