const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CacheSecurityGroup = @import("cache_security_group.zig").CacheSecurityGroup;
const serde = @import("serde.zig");

pub const RevokeCacheSecurityGroupIngressInput = struct {
    /// The name of the cache security group to revoke ingress from.
    cache_security_group_name: []const u8,

    /// The name of the Amazon EC2 security group to revoke access from.
    ec2_security_group_name: []const u8,

    /// The Amazon account number of the Amazon EC2 security group owner. Note that
    /// this is
    /// not the same thing as an Amazon access key ID - you must provide a valid
    /// Amazon account
    /// number for this parameter.
    ec2_security_group_owner_id: []const u8,
};

pub const RevokeCacheSecurityGroupIngressOutput = struct {
    cache_security_group: ?CacheSecurityGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RevokeCacheSecurityGroupIngressInput, options: CallOptions) !RevokeCacheSecurityGroupIngressOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RevokeCacheSecurityGroupIngressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RevokeCacheSecurityGroupIngress&Version=2015-02-02");
    try body_buf.appendSlice(allocator, "&CacheSecurityGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cache_security_group_name);
    try body_buf.appendSlice(allocator, "&EC2SecurityGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ec2_security_group_name);
    try body_buf.appendSlice(allocator, "&EC2SecurityGroupOwnerId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ec2_security_group_owner_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RevokeCacheSecurityGroupIngressOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RevokeCacheSecurityGroupIngressResult")) break;
            },
            else => {},
        }
    }

    var result: RevokeCacheSecurityGroupIngressOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheSecurityGroup")) {
                    result.cache_security_group = try serde.deserializeCacheSecurityGroup(allocator, &reader);
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
