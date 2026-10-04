const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlobalReplicationGroup = @import("global_replication_group.zig").GlobalReplicationGroup;
const serde = @import("serde.zig");

pub const CreateGlobalReplicationGroupInput = struct {
    /// Provides details of the Global datastore
    global_replication_group_description: ?[]const u8 = null,

    /// The suffix name of a Global datastore. Amazon ElastiCache automatically
    /// applies a
    /// prefix to the Global datastore ID when it is created. Each Amazon Region has
    /// its own
    /// prefix. For instance, a Global datastore ID created in the US-West-1 region
    /// will begin
    /// with "dsdfu" along with the suffix name you provide. The suffix, combined
    /// with the
    /// auto-generated prefix, guarantees uniqueness of the Global datastore name
    /// across
    /// multiple regions.
    ///
    /// For a full list of Amazon Regions and their respective Global datastore iD
    /// prefixes,
    /// see [Using the Amazon CLI with Global datastores
    /// ](http://docs.aws.amazon.com/AmazonElastiCache/latest/dg/Redis-Global-Datastores-CLI.html).
    global_replication_group_id_suffix: []const u8,

    /// The name of the primary cluster that accepts writes and will replicate
    /// updates to the
    /// secondary cluster. This value is stored as a lowercase string.
    primary_replication_group_id: []const u8,
};

pub const CreateGlobalReplicationGroupOutput = struct {
    global_replication_group: ?GlobalReplicationGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGlobalReplicationGroupInput, options: CallOptions) !CreateGlobalReplicationGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGlobalReplicationGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateGlobalReplicationGroup&Version=2015-02-02");
    if (input.global_replication_group_description) |v| {
        try body_buf.appendSlice(allocator, "&GlobalReplicationGroupDescription=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&GlobalReplicationGroupIdSuffix=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.global_replication_group_id_suffix);
    try body_buf.appendSlice(allocator, "&PrimaryReplicationGroupId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.primary_replication_group_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGlobalReplicationGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateGlobalReplicationGroupResult")) break;
            },
            else => {},
        }
    }

    var result: CreateGlobalReplicationGroupOutput = .{};
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
