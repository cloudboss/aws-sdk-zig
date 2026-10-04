const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Endpoint = @import("endpoint.zig").Endpoint;
const serde = @import("serde.zig");

pub const ListEndpointsByPlatformApplicationInput = struct {
    /// `NextToken` string is used when calling
    /// `ListEndpointsByPlatformApplication` action to retrieve additional
    /// records that are available after the first page results.
    next_token: ?[]const u8 = null,

    /// `PlatformApplicationArn` for
    /// `ListEndpointsByPlatformApplicationInput` action.
    platform_application_arn: []const u8,
};

pub const ListEndpointsByPlatformApplicationOutput = struct {
    /// Endpoints returned for `ListEndpointsByPlatformApplication` action.
    endpoints: ?[]const Endpoint = null,

    /// `NextToken` string is returned when calling
    /// `ListEndpointsByPlatformApplication` action if additional records are
    /// available after the first page results.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEndpointsByPlatformApplicationInput, options: CallOptions) !ListEndpointsByPlatformApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sns", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEndpointsByPlatformApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListEndpointsByPlatformApplication&Version=2010-03-31");
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&PlatformApplicationArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.platform_application_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEndpointsByPlatformApplicationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListEndpointsByPlatformApplicationResult")) break;
            },
            else => {},
        }
    }

    var result: ListEndpointsByPlatformApplicationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Endpoints")) {
                    result.endpoints = try serde.deserializeListOfEndpoints(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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
