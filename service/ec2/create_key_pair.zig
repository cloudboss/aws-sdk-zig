const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const KeyFormat = @import("key_format.zig").KeyFormat;
const KeyType = @import("key_type.zig").KeyType;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const Tag = @import("tag.zig").Tag;

/// Creates an ED25519 or 2048-bit RSA key pair with the specified name and in
/// the
/// specified format. Amazon EC2 stores the public key and displays the private
/// key for you to save to a file. The private key is returned as an unencrypted
/// PEM encoded
/// PKCS#1 private key or an unencrypted PPK formatted private key for use with
/// PuTTY. If a
/// key with the specified name already exists, Amazon EC2 returns an error.
///
/// The key pair returned to you is available only in the Amazon Web Services
/// Region in which you create it.
/// If you prefer, you can create your own key pair using a third-party tool and
/// upload it
/// to any Region using ImportKeyPair.
///
/// You can have up to 5,000 key pairs per Amazon Web Services Region.
///
/// For more information, see [Amazon EC2 key
/// pairs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) in the
/// *Amazon EC2 User Guide*.
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateKeyPairOutput) void {
        if (self.key_fingerprint) |v| {
            self.allocator.free(v);
        }
        if (self.key_material) |v| {
            self.allocator.free(v);
        }
        if (self.key_name) |v| {
            self.allocator.free(v);
        }
        if (self.key_pair_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateKeyPairInput, options: Options) !CreateKeyPairOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateKeyPairInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateKeyPair&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.key_format) |v| {
        try body_buf.appendSlice(alloc, "&KeyFormat=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&KeyName=");
    try appendUrlEncoded(alloc, &body_buf, input.key_name);
    if (input.key_type) |v| {
        try body_buf.appendSlice(alloc, "&KeyType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateKeyPairOutput {
    _ = status;
    _ = headers;
    var result: CreateKeyPairOutput = .{ .allocator = alloc };
    if (findElement(body, "keyFingerprint")) |content| {
        result.key_fingerprint = try alloc.dupe(u8, content);
    }
    if (findElement(body, "keyMaterial")) |content| {
        result.key_material = try alloc.dupe(u8, content);
    }
    if (findElement(body, "keyName")) |content| {
        result.key_name = try alloc.dupe(u8, content);
    }
    if (findElement(body, "keyPairId")) |content| {
        result.key_pair_id = try alloc.dupe(u8, content);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
