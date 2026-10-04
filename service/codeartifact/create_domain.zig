const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DomainDescription = @import("domain_description.zig").DomainDescription;

pub const CreateDomainInput = struct {
    /// The name of the domain to create. All domain names in an Amazon Web Services
    /// Region that are in the
    /// same Amazon Web Services account must be unique. The domain name is used as
    /// the prefix in DNS hostnames. Do
    /// not use sensitive information in a domain name because it is publicly
    /// discoverable.
    domain: []const u8,

    /// The encryption key for the domain. This is used to encrypt content stored in
    /// a domain.
    /// An encryption key can be a key ID, a key Amazon Resource Name (ARN), a key
    /// alias, or a key
    /// alias ARN. To specify an `encryptionKey`, your IAM role must have
    /// `kms:DescribeKey` and `kms:CreateGrant` permissions on the encryption
    /// key that is used. For more information, see
    /// [DescribeKey](https://docs.aws.amazon.com/kms/latest/APIReference/API_DescribeKey.html#API_DescribeKey_RequestSyntax) in the *Key Management Service API Reference*
    /// and [Key Management Service API Permissions
    /// Reference](https://docs.aws.amazon.com/kms/latest/developerguide/kms-api-permissions-reference.html) in the *Key Management Service Developer Guide*.
    ///
    /// CodeArtifact supports only symmetric CMKs. Do not associate an asymmetric
    /// CMK with your
    /// domain. For more information, see [Using symmetric and asymmetric
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html) in the *Key Management Service Developer Guide*.
    encryption_key: ?[]const u8 = null,

    /// One or more tag key-value pairs for the domain.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .domain = "domain",
        .encryption_key = "encryptionKey",
        .tags = "tags",
    };
};

pub const CreateDomainOutput = struct {
    /// Contains information about the created domain after processing the request.
    domain: ?DomainDescription = null,

    pub const json_field_names = .{
        .domain = "domain",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainInput, options: CallOptions) !CreateDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeartifact", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/domain";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "domain=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.domain);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.encryption_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDomainOutput {
    var result: CreateDomainOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDomainOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
