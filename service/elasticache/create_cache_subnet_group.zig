const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const CacheSubnetGroup = @import("cache_subnet_group.zig").CacheSubnetGroup;
const serde = @import("serde.zig");

pub const CreateCacheSubnetGroupInput = struct {
    /// A description for the cache subnet group.
    cache_subnet_group_description: []const u8,

    /// A name for the cache subnet group. This value is stored as a lowercase
    /// string.
    ///
    /// Constraints: Must contain no more than 255 alphanumeric characters or
    /// hyphens.
    ///
    /// Example: `mysubnetgroup`
    cache_subnet_group_name: []const u8,

    /// A list of VPC subnet IDs for the cache subnet group.
    subnet_ids: []const []const u8,

    /// A list of tags to be added to this resource. A tag is a key-value pair. A
    /// tag key must
    /// be accompanied by a tag value, although null is accepted.
    tags: ?[]const Tag = null,
};

pub const CreateCacheSubnetGroupOutput = struct {
    cache_subnet_group: ?CacheSubnetGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCacheSubnetGroupInput, options: CallOptions) !CreateCacheSubnetGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticache", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCacheSubnetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateCacheSubnetGroup&Version=2015-02-02");
    try body_buf.appendSlice(allocator, "&CacheSubnetGroupDescription=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cache_subnet_group_description);
    try body_buf.appendSlice(allocator, "&CacheSubnetGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cache_subnet_group_name);
    for (input.subnet_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetIds.SubnetIdentifier.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCacheSubnetGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateCacheSubnetGroupResult")) break;
            },
            else => {},
        }
    }

    var result: CreateCacheSubnetGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheSubnetGroup")) {
                    result.cache_subnet_group = try serde.deserializeCacheSubnetGroup(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
