const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceQuery = @import("resource_query.zig").ResourceQuery;
const GroupQuery = @import("group_query.zig").GroupQuery;

pub const UpdateGroupQueryInput = struct {
    /// The name or the Amazon resource name (ARN) of the resource group to query.
    group: ?[]const u8 = null,

    /// Don't use this parameter. Use `Group` instead.
    group_name: ?[]const u8 = null,

    /// The resource query to determine which Amazon Web Services resources are
    /// members of this resource
    /// group.
    ///
    /// A resource group can contain either a `Configuration` or a
    /// `ResourceQuery`, but not both.
    resource_query: ResourceQuery,

    pub const json_field_names = .{
        .group = "Group",
        .group_name = "GroupName",
        .resource_query = "ResourceQuery",
    };
};

pub const UpdateGroupQueryOutput = struct {
    /// The updated resource query associated with the resource group after the
    /// update.
    group_query: ?GroupQuery = null,

    pub const json_field_names = .{
        .group_query = "GroupQuery",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGroupQueryInput, options: CallOptions) !UpdateGroupQueryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGroupQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-groups", "Resource Groups", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/update-group-query";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceQuery\":");
    try aws.json.writeValue(@TypeOf(input.resource_query), input.resource_query, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGroupQueryOutput {
    var result: UpdateGroupQueryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateGroupQueryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
