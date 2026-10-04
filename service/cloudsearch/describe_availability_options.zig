const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AvailabilityOptionsStatus = @import("availability_options_status.zig").AvailabilityOptionsStatus;
const serde = @import("serde.zig");

pub const DescribeAvailabilityOptionsInput = struct {
    /// Whether to display the deployed configuration (`true`) or include any
    /// pending changes (`false`). Defaults to `false`.
    deployed: ?bool = null,

    /// The name of the domain you want to describe.
    domain_name: []const u8,
};

pub const DescribeAvailabilityOptionsOutput = struct {
    /// The availability options configured for the domain. Indicates whether
    /// Multi-AZ is enabled for the domain.
    availability_options: ?AvailabilityOptionsStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAvailabilityOptionsInput, options: CallOptions) !DescribeAvailabilityOptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudsearch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAvailabilityOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudsearch", "CloudSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeAvailabilityOptions&Version=2013-01-01");
    if (input.deployed) |v| {
        try body_buf.appendSlice(allocator, "&Deployed=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&DomainName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.domain_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAvailabilityOptionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeAvailabilityOptionsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeAvailabilityOptionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityOptions")) {
                    result.availability_options = try serde.deserializeAvailabilityOptionsStatus(allocator, &reader);
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
