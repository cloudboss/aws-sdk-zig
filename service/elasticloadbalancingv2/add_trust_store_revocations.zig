const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RevocationContent = @import("revocation_content.zig").RevocationContent;
const TrustStoreRevocation = @import("trust_store_revocation.zig").TrustStoreRevocation;
const serde = @import("serde.zig");

pub const AddTrustStoreRevocationsInput = struct {
    /// The revocation file to add.
    revocation_contents: ?[]const RevocationContent = null,

    /// The Amazon Resource Name (ARN) of the trust store.
    trust_store_arn: []const u8,
};

pub const AddTrustStoreRevocationsOutput = struct {
    /// Information about the revocation file added to the trust store.
    trust_store_revocations: ?[]const TrustStoreRevocation = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddTrustStoreRevocationsInput, options: CallOptions) !AddTrustStoreRevocationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddTrustStoreRevocationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=AddTrustStoreRevocations&Version=2015-12-01");
    if (input.revocation_contents) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.revocation_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RevocationContents.member.{d}.RevocationType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.s3_bucket) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RevocationContents.member.{d}.S3Bucket=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.s3_key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RevocationContents.member.{d}.S3Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.s3_object_version) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RevocationContents.member.{d}.S3ObjectVersion=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddTrustStoreRevocationsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AddTrustStoreRevocationsResult")) break;
            },
            else => {},
        }
    }

    var result: AddTrustStoreRevocationsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TrustStoreRevocations")) {
                    result.trust_store_revocations = try serde.deserializeTrustStoreRevocations(allocator, &reader, "member");
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
