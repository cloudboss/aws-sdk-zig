const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TagResourceType = @import("tag_resource_type.zig").TagResourceType;
const ResourceTagSet = @import("resource_tag_set.zig").ResourceTagSet;
const serde = @import("serde.zig");

pub const ListTagsForResourcesInput = struct {
    /// A complex type that contains the ResourceId element for each resource for
    /// which you
    /// want to get a list of tags.
    resource_ids: []const []const u8,

    /// The type of the resources.
    ///
    /// * The resource type for health checks is `healthcheck`.
    ///
    /// * The resource type for hosted zones is `hostedzone`.
    resource_type: TagResourceType,
};

pub const ListTagsForResourcesOutput = struct {
    /// A list of `ResourceTagSet`s containing tags associated with the specified
    /// resources.
    resource_tag_sets: ?[]const ResourceTagSet = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTagsForResourcesInput, options: CallOptions) !ListTagsForResourcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTagsForResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/tags/");
    try path_buf.appendSlice(allocator, input.resource_type.wireName());
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<ListTagsForResourcesRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    try body_buf.appendSlice(allocator, "<ResourceIds>");
    try serde.serializeTagResourceIdList(allocator, &body_buf, input.resource_ids, "ResourceId");
    try body_buf.appendSlice(allocator, "</ResourceIds>");
    try body_buf.appendSlice(allocator, "</ListTagsForResourcesRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTagsForResourcesOutput {
    var result: ListTagsForResourcesOutput = undefined;
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceTagSets")) {
                    result.resource_tag_sets = try serde.deserializeResourceTagSetList(allocator, &reader, "ResourceTagSet");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
