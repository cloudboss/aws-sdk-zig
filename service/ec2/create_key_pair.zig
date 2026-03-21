const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const KeyFormat = @import("key_format.zig").KeyFormat;
const KeyType = @import("key_type.zig").KeyType;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateKeyPairInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The format of the key pair.
    ///
    /// Default: `pem`
    key_format: ?KeyFormat = null,

    /// A unique name for the key pair.
    ///
    /// Constraints: Up to 255 ASCII characters
    key_name: []const u8,

    /// The type of key pair. Note that ED25519 keys are not supported for Windows
    /// instances.
    ///
    /// Default: `rsa`
    key_type: ?KeyType = null,

    /// The tags to apply to the new key pair.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateKeyPairOutput = struct {
    /// * For RSA key pairs, the key fingerprint is the SHA-1 digest of the DER
    ///   encoded private key.
    ///
    /// * For ED25519 key pairs, the key fingerprint is the base64-encoded SHA-256
    ///   digest, which is the default for OpenSSH, starting with OpenSSH 6.8.
    key_fingerprint: ?[]const u8 = null,

    /// An unencrypted PEM encoded RSA or ED25519 private key.
    key_material: ?[]const u8 = null,

    /// The name of the key pair.
    key_name: ?[]const u8 = null,

    /// The ID of the key pair.
    key_pair_id: ?[]const u8 = null,

    /// Any tags applied to the key pair.
    tags: ?[]const Tag = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateKeyPairInput, options: CallOptions) !CreateKeyPairOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKeyPairInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateKeyPair&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.key_format) |v| {
        try body_buf.appendSlice(allocator, "&KeyFormat=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&KeyName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.key_name);
    if (input.key_type) |v| {
        try body_buf.appendSlice(allocator, "&KeyType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.ResourceType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.key) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Key=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Value=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKeyPairOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateKeyPairOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "keyFingerprint")) {
                    result.key_fingerprint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "keyMaterial")) {
                    result.key_material = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "keyName")) {
                    result.key_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "keyPairId")) {
                    result.key_pair_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "tagSet")) {
                    result.tags = try serde.deserializeTagList(allocator, &reader, "item");
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
