const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const encodingType = @import("encoding_type.zig").encodingType;
const SSHPublicKey = @import("ssh_public_key.zig").SSHPublicKey;
const serde = @import("serde.zig");

pub const GetSSHPublicKeyInput = struct {
    /// Specifies the public key encoding format to use in the response. To retrieve
    /// the
    /// public key in ssh-rsa format, use `SSH`. To retrieve the public key in PEM
    /// format, use `PEM`.
    encoding: encodingType,

    /// The unique identifier for the SSH public key.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters that can
    /// consist of any upper or lowercased letter or digit.
    ssh_public_key_id: []const u8,

    /// The name of the IAM user associated with the SSH public key.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    user_name: []const u8,
};

pub const GetSSHPublicKeyOutput = struct {
    /// A structure containing details about the SSH public key.
    ssh_public_key: ?SSHPublicKey = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSSHPublicKeyInput, options: CallOptions) !GetSSHPublicKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSSHPublicKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetSSHPublicKey&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&Encoding=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.encoding.wireName());
    try body_buf.appendSlice(allocator, "&SSHPublicKeyId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ssh_public_key_id);
    try body_buf.appendSlice(allocator, "&UserName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.user_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSSHPublicKeyOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetSSHPublicKeyResult")) break;
            },
            else => {},
        }
    }

    var result: GetSSHPublicKeyOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SSHPublicKey")) {
                    result.ssh_public_key = try serde.deserializeSSHPublicKey(allocator, &reader);
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
