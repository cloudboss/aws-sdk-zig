const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const SnapshotCopyGrant = @import("snapshot_copy_grant.zig").SnapshotCopyGrant;
const serde = @import("serde.zig");

pub const CreateSnapshotCopyGrantInput = struct {
    /// The unique identifier of the encrypted symmetric key to which to grant
    /// Amazon Redshift
    /// permission. If no key is specified, the default key is used.
    kms_key_id: ?[]const u8 = null,

    /// The name of the snapshot copy grant. This name must be unique in the region
    /// for the
    /// Amazon Web Services account.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 alphanumeric characters or hyphens.
    ///
    /// * Alphabetic characters must be lowercase.
    ///
    /// * First character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    ///
    /// * Must be unique for all clusters within an Amazon Web Services account.
    snapshot_copy_grant_name: []const u8,

    /// A list of tag instances.
    tags: ?[]const Tag = null,
};

pub const CreateSnapshotCopyGrantOutput = struct {
    snapshot_copy_grant: ?SnapshotCopyGrant = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSnapshotCopyGrantInput, options: CallOptions) !CreateSnapshotCopyGrantOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSnapshotCopyGrantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateSnapshotCopyGrant&Version=2012-12-01");
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&SnapshotCopyGrantName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.snapshot_copy_grant_name);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSnapshotCopyGrantOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateSnapshotCopyGrantResult")) break;
            },
            else => {},
        }
    }

    var result: CreateSnapshotCopyGrantOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SnapshotCopyGrant")) {
                    result.snapshot_copy_grant = try serde.deserializeSnapshotCopyGrant(allocator, &reader);
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
