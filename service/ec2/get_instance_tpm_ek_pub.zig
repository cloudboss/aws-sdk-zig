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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetInstanceTpmEkPubOutput) void {
        self._arena.deinit();
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetInstanceTpmEkPubInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetInstanceTpmEkPub&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.instance_id);
    try body_buf.appendSlice(alloc, "&KeyFormat=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.key_format));
    try body_buf.appendSlice(alloc, "&KeyType=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.key_type));

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetInstanceTpmEkPubOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetInstanceTpmEkPubOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instanceId")) {
                    result.instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "keyFormat")) {
                    result.key_format = std.meta.stringToEnum(EkPubKeyFormat, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "keyType")) {
                    result.key_type = std.meta.stringToEnum(EkPubKeyType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "keyValue")) {
                    result.key_value = try alloc.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
