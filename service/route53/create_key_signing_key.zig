const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeInfo = @import("change_info.zig").ChangeInfo;
const KeySigningKey = @import("key_signing_key.zig").KeySigningKey;
const serde = @import("serde.zig");

pub const CreateKeySigningKeyInput = struct {
    /// A unique string that identifies the request.
    caller_reference: []const u8,

    /// The unique string (ID) used to identify a hosted zone.
    hosted_zone_id: []const u8,

    /// The Amazon resource name (ARN) for a customer managed key in Key Management
    /// Service
    /// (KMS). The `KeyManagementServiceArn` must be unique for
    /// each key-signing key (KSK) in a single hosted zone. To see an example of
    /// `KeyManagementServiceArn` that grants the correct permissions for DNSSEC,
    /// scroll down to **Example**.
    ///
    /// You must configure the customer managed customer managed key as follows:
    ///
    /// **Status**
    ///
    /// Enabled
    ///
    /// **Key spec**
    ///
    /// ECC_NIST_P256
    ///
    /// **Key usage**
    ///
    /// Sign and verify
    ///
    /// **Key policy**
    ///
    /// The key policy must give permission for the following actions:
    ///
    /// * DescribeKey
    ///
    /// * GetPublicKey
    ///
    /// * Sign
    ///
    /// The key policy must also include the Amazon Route 53 service in the
    /// principal for your account. Specify the following:
    ///
    /// * `"Service": "dnssec-route53.amazonaws.com"`
    ///
    /// For more information about working with a customer managed key in KMS, see
    /// [Key Management Service
    /// concepts](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html).
    key_management_service_arn: []const u8,

    /// A string used to identify a key-signing key (KSK). `Name` can include
    /// numbers, letters, and underscores (_). `Name` must be unique for each
    /// key-signing key in the same hosted zone.
    name: []const u8,

    /// A string specifying the initial status of the key-signing key (KSK). You can
    /// set the
    /// value to `ACTIVE` or `INACTIVE`.
    status: []const u8,
};

pub const CreateKeySigningKeyOutput = struct {
    change_info: ?ChangeInfo = null,

    /// The key-signing key (KSK) that the request creates.
    key_signing_key: ?KeySigningKey = null,

    /// The unique URL representing the new key-signing key (KSK).
    location: []const u8,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateKeySigningKeyInput, options: CallOptions) !CreateKeySigningKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKeySigningKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/keysigningkey";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateKeySigningKeyRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    try body_buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.caller_reference);
    try body_buf.appendSlice(allocator, "</CallerReference>");
    try body_buf.appendSlice(allocator, "<HostedZoneId>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.hosted_zone_id);
    try body_buf.appendSlice(allocator, "</HostedZoneId>");
    try body_buf.appendSlice(allocator, "<KeyManagementServiceArn>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.key_management_service_arn);
    try body_buf.appendSlice(allocator, "</KeyManagementServiceArn>");
    try body_buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.name);
    try body_buf.appendSlice(allocator, "</Name>");
    try body_buf.appendSlice(allocator, "<Status>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.status);
    try body_buf.appendSlice(allocator, "</Status>");
    try body_buf.appendSlice(allocator, "</CreateKeySigningKeyRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKeySigningKeyOutput {
    var result: CreateKeySigningKeyOutput = undefined;
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChangeInfo")) {
                    result.change_info = try serde.deserializeChangeInfo(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "KeySigningKey")) {
                    result.key_signing_key = try serde.deserializeKeySigningKey(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
