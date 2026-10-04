const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const assertionEncryptionModeType = @import("assertion_encryption_mode_type.zig").assertionEncryptionModeType;
const SAMLPrivateKey = @import("saml_private_key.zig").SAMLPrivateKey;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const GetSAMLProviderInput = struct {
    /// The Amazon Resource Name (ARN) of the SAML provider resource object in IAM
    /// to get
    /// information about.
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    saml_provider_arn: []const u8,
};

pub const GetSAMLProviderOutput = struct {
    /// Specifies the encryption setting for the SAML provider.
    assertion_encryption_mode: ?assertionEncryptionModeType = null,

    /// The date and time when the SAML provider was created.
    create_date: ?i64 = null,

    /// The private key metadata for the SAML provider.
    private_key_list: ?[]const SAMLPrivateKey = null,

    /// The XML metadata document that includes information about an identity
    /// provider.
    saml_metadata_document: ?[]const u8 = null,

    /// The unique identifier assigned to the SAML provider.
    saml_provider_uuid: ?[]const u8 = null,

    /// A list of tags that are attached to the specified IAM SAML provider. The
    /// returned list of tags is sorted by tag key.
    /// For more information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    tags: ?[]const Tag = null,

    /// The expiration date and time for the SAML provider.
    valid_until: ?i64 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSAMLProviderInput, options: CallOptions) !GetSAMLProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSAMLProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetSAMLProvider&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&SAMLProviderArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.saml_provider_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSAMLProviderOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetSAMLProviderResult")) break;
            },
            else => {},
        }
    }

    var result: GetSAMLProviderOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AssertionEncryptionMode")) {
                    result.assertion_encryption_mode = assertionEncryptionModeType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "PrivateKeyList")) {
                    result.private_key_list = try serde.deserializeprivateKeyList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "SAMLMetadataDocument")) {
                    result.saml_metadata_document = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SAMLProviderUUID")) {
                    result.saml_provider_uuid = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try serde.deserializetagListType(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ValidUntil")) {
                    result.valid_until = aws.date.parseIso8601(try reader.readElementText()) catch null;
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
