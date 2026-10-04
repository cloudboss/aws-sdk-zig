const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DescribeTrustStoreRevocation = @import("describe_trust_store_revocation.zig").DescribeTrustStoreRevocation;
const serde = @import("serde.zig");

pub const DescribeTrustStoreRevocationsInput = struct {
    /// The marker for the next set of results. (You received this marker from a
    /// previous call.)
    marker: ?[]const u8 = null,

    /// The maximum number of results to return with this call.
    page_size: ?i32 = null,

    /// The revocation IDs of the revocation files you want to describe.
    revocation_ids: ?[]const i64 = null,

    /// The Amazon Resource Name (ARN) of the trust store.
    trust_store_arn: []const u8,
};

pub const DescribeTrustStoreRevocationsOutput = struct {
    /// If there are additional results, this is the marker for the next set of
    /// results.
    /// Otherwise, this is null.
    next_marker: ?[]const u8 = null,

    /// Information about the revocation file in the trust store.
    trust_store_revocations: ?[]const DescribeTrustStoreRevocation = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTrustStoreRevocationsInput, options: CallOptions) !DescribeTrustStoreRevocationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticloadbalancing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTrustStoreRevocationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeTrustStoreRevocations&Version=2015-12-01");
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.page_size) |v| {
        try body_buf.appendSlice(allocator, "&PageSize=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.revocation_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RevocationIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{item}) catch "");
        }
    }
    try body_buf.appendSlice(allocator, "&TrustStoreArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.trust_store_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTrustStoreRevocationsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeTrustStoreRevocationsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeTrustStoreRevocationsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustStoreRevocations")) {
                    result.trust_store_revocations = try serde.deserializeDescribeTrustStoreRevocationResponse(allocator, &reader, "member");
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
