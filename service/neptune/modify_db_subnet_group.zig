const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBSubnetGroup = @import("db_subnet_group.zig").DBSubnetGroup;
const serde = @import("serde.zig");

pub const ModifyDBSubnetGroupInput = struct {
    /// The description for the DB subnet group.
    db_subnet_group_description: ?[]const u8 = null,

    /// The name for the DB subnet group. This value is stored as a lowercase
    /// string. You can't
    /// modify the default subnet group.
    ///
    /// Constraints: Must match the name of an existing DBSubnetGroup. Must not be
    /// default.
    ///
    /// Example: `mySubnetgroup`
    db_subnet_group_name: []const u8,

    /// The EC2 subnet IDs for the DB subnet group.
    subnet_ids: []const []const u8,
};

pub const ModifyDBSubnetGroupOutput = struct {
    db_subnet_group: ?DBSubnetGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBSubnetGroupInput, options: CallOptions) !ModifyDBSubnetGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBSubnetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "Neptune", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBSubnetGroup&Version=2014-10-31");
    if (input.db_subnet_group_description) |v| {
        try body_buf.appendSlice(allocator, "&DBSubnetGroupDescription=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&DBSubnetGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_subnet_group_name);
    for (input.subnet_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetIds.SubnetIdentifier.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBSubnetGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBSubnetGroupResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBSubnetGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSubnetGroup")) {
                    result.db_subnet_group = try serde.deserializeDBSubnetGroup(allocator, &reader);
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
