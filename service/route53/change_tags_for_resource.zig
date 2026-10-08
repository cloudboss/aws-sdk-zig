const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const TagResourceType = @import("tag_resource_type.zig").TagResourceType;
const serde = @import("serde.zig");

pub const ChangeTagsForResourceInput = struct {
    /// A complex type that contains a list of the tags that you want to add to the
    /// specified
    /// health check or hosted zone and/or the tags that you want to edit `Value`
    /// for.
    ///
    /// You can add a maximum of 10 tags to a health check or a hosted zone.
    add_tags: ?[]const Tag = null,

    /// A complex type that contains a list of the tags that you want to delete from
    /// the
    /// specified health check or hosted zone. You can specify up to 10 keys.
    remove_tag_keys: ?[]const []const u8 = null,

    /// The ID of the resource for which you want to add, change, or delete tags.
    resource_id: []const u8,

    /// The type of the resource.
    ///
    /// * The resource type for health checks is `healthcheck`.
    ///
    /// * The resource type for hosted zones is `hostedzone`.
    resource_type: TagResourceType,
};

pub const ChangeTagsForResourceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ChangeTagsForResourceInput, options: CallOptions) !ChangeTagsForResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ChangeTagsForResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/tags/");
    try path_buf.appendSlice(allocator, input.resource_type.wireName());
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.resource_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<ChangeTagsForResourceRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    if (input.add_tags) |v| {
        try body_buf.appendSlice(allocator, "<AddTags>");
        try serde.serializeTagList(allocator, &body_buf, v, "Tag");
        try body_buf.appendSlice(allocator, "</AddTags>");
    }
    if (input.remove_tag_keys) |v| {
        try body_buf.appendSlice(allocator, "<RemoveTagKeys>");
        try serde.serializeTagKeyList(allocator, &body_buf, v, "Key");
        try body_buf.appendSlice(allocator, "</RemoveTagKeys>");
    }
    try body_buf.appendSlice(allocator, "</ChangeTagsForResourceRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ChangeTagsForResourceOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: ChangeTagsForResourceOutput = .{};

    return result;
}
