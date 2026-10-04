const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlobalReplicationGroup = @import("global_replication_group.zig").GlobalReplicationGroup;
const serde = @import("serde.zig");

pub const ModifyGlobalReplicationGroupInput = struct {
    /// This parameter causes the modifications in this request and any pending
    /// modifications
    /// to be applied, asynchronously and as soon as possible. Modifications to
    /// Global
    /// Replication Groups cannot be requested to be applied in
    /// PreferredMaintenceWindow.
    apply_immediately: bool,

    /// Determines whether a read replica is automatically promoted to read/write
    /// primary if
    /// the existing primary encounters a failure.
    automatic_failover_enabled: ?bool = null,

    /// A valid cache node type that you want to scale this Global datastore to.
    cache_node_type: ?[]const u8 = null,

    /// The name of the cache parameter group to use with the Global datastore. It
    /// must be
    /// compatible with the major engine version used by the Global datastore.
    cache_parameter_group_name: ?[]const u8 = null,

    /// Modifies the engine listed in a global replication group message. The
    /// options are valkey, memcached or redis.
    engine: ?[]const u8 = null,

    /// The upgraded version of the cache engine to be run on the clusters in the
    /// Global
    /// datastore.
    engine_version: ?[]const u8 = null,

    /// A description of the Global datastore
    global_replication_group_description: ?[]const u8 = null,

    /// The name of the Global datastore
    global_replication_group_id: []const u8,
};

pub const ModifyGlobalReplicationGroupOutput = struct {
    global_replication_group: ?GlobalReplicationGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyGlobalReplicationGroupInput, options: CallOptions) !ModifyGlobalReplicationGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyGlobalReplicationGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyGlobalReplicationGroup&Version=2015-02-02");
    try body_buf.appendSlice(allocator, "&ApplyImmediately=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.apply_immediately) "true" else "false");
    if (input.automatic_failover_enabled) |v| {
        try body_buf.appendSlice(allocator, "&AutomaticFailoverEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.cache_node_type) |v| {
        try body_buf.appendSlice(allocator, "&CacheNodeType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.cache_parameter_group_name) |v| {
        try body_buf.appendSlice(allocator, "&CacheParameterGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine) |v| {
        try body_buf.appendSlice(allocator, "&Engine=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.global_replication_group_description) |v| {
        try body_buf.appendSlice(allocator, "&GlobalReplicationGroupDescription=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&GlobalReplicationGroupId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.global_replication_group_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyGlobalReplicationGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyGlobalReplicationGroupResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyGlobalReplicationGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GlobalReplicationGroup")) {
                    result.global_replication_group = try serde.deserializeGlobalReplicationGroup(allocator, &reader);
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
