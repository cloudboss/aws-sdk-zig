const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityProvider = @import("identity_provider.zig").IdentityProvider;
const PublisherStatus = @import("publisher_status.zig").PublisherStatus;

pub const DescribePublisherInput = struct {
    /// The ID of the extension publisher.
    ///
    /// If you don't supply a `PublisherId`, and you have registered as an extension
    /// publisher, `DescribePublisher` returns information about your own publisher
    /// account.
    publisher_id: ?[]const u8 = null,
};

pub const DescribePublisherOutput = struct {
    /// The type of account used as the identity provider when registering this
    /// publisher with
    /// CloudFormation.
    identity_provider: ?IdentityProvider = null,

    /// The ID of the extension publisher.
    publisher_id: ?[]const u8 = null,

    /// The URL to the publisher's profile with the identity provider.
    publisher_profile: ?[]const u8 = null,

    /// Whether the publisher is verified. Currently, all registered publishers are
    /// verified.
    publisher_status: ?PublisherStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePublisherInput, options: CallOptions) !DescribePublisherOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePublisherInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribePublisher&Version=2010-05-15");
    if (input.publisher_id) |v| {
        try body_buf.appendSlice(allocator, "&PublisherId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePublisherOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribePublisherResult")) break;
            },
            else => {},
        }
    }

    var result: DescribePublisherOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IdentityProvider")) {
                    result.identity_provider = IdentityProvider.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublisherId")) {
                    result.publisher_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublisherProfile")) {
                    result.publisher_profile = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublisherStatus")) {
                    result.publisher_status = PublisherStatus.fromWireName(try reader.readElementText());
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
