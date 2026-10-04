const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const CacheParameterGroup = @import("cache_parameter_group.zig").CacheParameterGroup;
const serde = @import("serde.zig");

pub const CreateCacheParameterGroupInput = struct {
    /// The name of the cache parameter group family that the cache parameter group
    /// can be
    /// used with.
    ///
    /// Valid values are: `valkey8` | `valkey7` | `memcached1.4` | `memcached1.5` |
    /// `memcached1.6` | `redis2.6` | `redis2.8` |
    /// `redis3.2` | `redis4.0` | `redis5.0` | `redis6.x` | `redis7`
    cache_parameter_group_family: []const u8,

    /// A user-specified name for the cache parameter group. This value is stored as
    /// a lowercase string.
    cache_parameter_group_name: []const u8,

    /// A user-specified description for the cache parameter group.
    description: []const u8,

    /// A list of tags to be added to this resource. A tag is a key-value pair. A
    /// tag key must
    /// be accompanied by a tag value, although null is accepted.
    tags: ?[]const Tag = null,
};

pub const CreateCacheParameterGroupOutput = struct {
    cache_parameter_group: ?CacheParameterGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCacheParameterGroupInput, options: CallOptions) !CreateCacheParameterGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCacheParameterGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateCacheParameterGroup&Version=2015-02-02");
    try body_buf.appendSlice(allocator, "&CacheParameterGroupFamily=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cache_parameter_group_family);
    try body_buf.appendSlice(allocator, "&CacheParameterGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cache_parameter_group_name);
    try body_buf.appendSlice(allocator, "&Description=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.description);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCacheParameterGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateCacheParameterGroupResult")) break;
            },
            else => {},
        }
    }

    var result: CreateCacheParameterGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheParameterGroup")) {
                    result.cache_parameter_group = try serde.deserializeCacheParameterGroup(allocator, &reader);
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
