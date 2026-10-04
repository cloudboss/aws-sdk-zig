const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const RemoveTagsFromResourceInput = struct {
    /// The Amazon Resource Name (ARN) of the resource from which you want the tags
    /// removed,
    /// for example `arn:aws:elasticache:us-west-2:0123456789:cluster:myCluster` or
    /// `arn:aws:elasticache:us-west-2:0123456789:snapshot:mySnapshot`.
    ///
    /// For more information about ARNs, see [Amazon Resource Names (ARNs)
    /// and Amazon Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    resource_name: []const u8,

    /// A list of `TagKeys` identifying the tags you want removed from the named
    /// resource.
    tag_keys: []const []const u8,
};

pub const RemoveTagsFromResourceOutput = struct {
    /// A list of tags as key-value pairs.
    tag_list: ?[]const Tag = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RemoveTagsFromResourceInput, options: CallOptions) !RemoveTagsFromResourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RemoveTagsFromResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RemoveTagsFromResource&Version=2015-02-02");
    try body_buf.appendSlice(allocator, "&ResourceName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.resource_name);
    for (input.tag_keys, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagKeys.member.{d}=", .{n}) catch continue;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RemoveTagsFromResourceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RemoveTagsFromResourceResult")) break;
            },
            else => {},
        }
    }

    var result: RemoveTagsFromResourceOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try serde.deserializeTagList(allocator, &reader, "Tag");
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
