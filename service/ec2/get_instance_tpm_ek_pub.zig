const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EkPubKeyFormat = @import("ek_pub_key_format.zig").EkPubKeyFormat;
const EkPubKeyType = @import("ek_pub_key_type.zig").EkPubKeyType;

/// Gets the public endorsement key associated with the Nitro Trusted
/// Platform Module (NitroTPM) for the specified instance.
pub const GetInstanceTpmEkPubInput = struct {
    /// Specify this parameter to verify whether the request will succeed, without
    /// actually making the
    /// request. If the request will succeed, the response is `DryRunOperation`.
    /// Otherwise,
    /// the response is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the instance for which to get the public endorsement key.
    instance_id: []const u8,

    /// The required public endorsement key format. Specify `der` for a DER-encoded
    /// public
    /// key that is compatible with OpenSSL. Specify `tpmt` for a TPM 2.0 format
    /// that is
    /// compatible with tpm2-tools. The returned key is base64 encoded.
    key_format: EkPubKeyFormat,

    /// The required public endorsement key type.
    key_type: EkPubKeyType,
};

pub const GetInstanceTpmEkPubOutput = struct {
    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The public endorsement key format.
    key_format: ?EkPubKeyFormat = null,

    /// The public endorsement key type.
    key_type: ?EkPubKeyType = null,

    /// The public endorsement key material.
    key_value: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const GetInstanceTpmEkPubOutput) void {
        if (self.instance_id) |v| {
            self.allocator.free(v);
        }
        if (self.key_value) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetInstanceTpmEkPubInput, options: Options) !GetInstanceTpmEkPubOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetInstanceTpmEkPubInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetInstanceTpmEkPub&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try appendUrlEncoded(alloc, &body_buf, input.instance_id);
    try body_buf.appendSlice(alloc, "&KeyFormat=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.key_format));
    try body_buf.appendSlice(alloc, "&KeyType=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.key_type));

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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !GetInstanceTpmEkPubOutput {
    _ = status;
    var result: GetInstanceTpmEkPubOutput = .{ .allocator = alloc };
    if (findElement(body, "instanceId")) |content| {
        result.instance_id = try alloc.dupe(u8, content);
    }
    if (findElement(body, "keyValue")) |content| {
        result.key_value = try alloc.dupe(u8, content);
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
