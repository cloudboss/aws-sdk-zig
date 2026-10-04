const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const TrustStore = @import("trust_store.zig").TrustStore;
const serde = @import("serde.zig");

pub const CreateTrustStoreInput = struct {
    /// The Amazon S3 bucket for the ca certificates bundle.
    ca_certificates_bundle_s3_bucket: []const u8,

    /// The Amazon S3 path for the ca certificates bundle.
    ca_certificates_bundle_s3_key: []const u8,

    /// The Amazon S3 object version for the ca certificates bundle. If undefined
    /// the current version is used.
    ca_certificates_bundle_s3_object_version: ?[]const u8 = null,

    /// The name of the trust store.
    ///
    /// This name must be unique per region and can't be changed after creation.
    name: []const u8,

    /// The tags to assign to the trust store.
    tags: ?[]const Tag = null,
};

pub const CreateTrustStoreOutput = struct {
    /// Information about the trust store created.
    trust_stores: ?[]const TrustStore = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrustStoreInput, options: CallOptions) !CreateTrustStoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrustStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateTrustStore&Version=2015-12-01");
    try body_buf.appendSlice(allocator, "&CaCertificatesBundleS3Bucket=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ca_certificates_bundle_s3_bucket);
    try body_buf.appendSlice(allocator, "&CaCertificatesBundleS3Key=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ca_certificates_bundle_s3_key);
    if (input.ca_certificates_bundle_s3_object_version) |v| {
        try body_buf.appendSlice(allocator, "&CaCertificatesBundleS3ObjectVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&Name=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.name);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrustStoreOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateTrustStoreResult")) break;
            },
            else => {},
        }
    }

    var result: CreateTrustStoreOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TrustStores")) {
                    result.trust_stores = try serde.deserializeTrustStores(allocator, &reader, "member");
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
