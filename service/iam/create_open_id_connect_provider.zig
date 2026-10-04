const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateOpenIDConnectProviderInput = struct {
    /// Provides a list of client IDs, also known as audiences. When a mobile or web
    /// app
    /// registers with an OpenID Connect provider, they establish a value that
    /// identifies the
    /// application. This is the value that's sent as the `client_id` parameter on
    /// OAuth requests.
    ///
    /// You can register multiple client IDs with the same provider. For example,
    /// you might
    /// have multiple applications that use the same OIDC provider. You cannot
    /// register more
    /// than 100 client IDs with a single IAM OIDC provider.
    ///
    /// There is no defined format for a client ID. The
    /// `CreateOpenIDConnectProviderRequest` operation accepts client IDs up to
    /// 255 characters long.
    client_id_list: ?[]const []const u8 = null,

    /// A list of tags that you want to attach to the new IAM OpenID Connect (OIDC)
    /// provider.
    /// Each tag consists of a key name and an associated value. For more
    /// information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// If any one of the tags is invalid or if you exceed the allowed maximum
    /// number of tags, then the entire request
    /// fails and the resource is not created.
    tags: ?[]const Tag = null,

    /// A list of server certificate thumbprints for the OpenID Connect (OIDC)
    /// identity
    /// provider's server certificates. Typically this list includes only one entry.
    /// However,
    /// IAM lets you have up to five thumbprints for an OIDC provider. This lets you
    /// maintain
    /// multiple thumbprints if the identity provider is rotating certificates.
    ///
    /// This parameter is optional. If it is not included, IAM will retrieve and use
    /// the top
    /// intermediate certificate authority (CA) thumbprint of the OpenID Connect
    /// identity
    /// provider server certificate.
    ///
    /// The server certificate thumbprint is the hex-encoded SHA-1 hash value of the
    /// X.509
    /// certificate used by the domain where the OpenID Connect provider makes its
    /// keys
    /// available. It is always a 40-character string.
    ///
    /// For example, assume that the OIDC provider is `server.example.com` and the
    /// provider stores its keys at https://keys.server.example.com/openid-connect.
    /// In that
    /// case, the thumbprint string would be the hex-encoded SHA-1 hash value of the
    /// certificate
    /// used by `https://keys.server.example.com.`
    ///
    /// For more information about obtaining the OIDC provider thumbprint, see
    /// [Obtaining the
    /// thumbprint for an OpenID Connect
    /// provider](https://docs.aws.amazon.com/IAM/latest/UserGuide/identity-providers-oidc-obtain-thumbprint.html) in the *IAM user
    /// Guide*.
    ///
    /// If your OIDC provider's discovery endpoint and JWKS endpoint
    /// (`jwks_uri`) use different certificates or hosts, include the
    /// thumbprints for both endpoints in this list.
    thumbprint_list: ?[]const []const u8 = null,

    /// The URL of the identity provider. The URL must begin with `https://` and
    /// should correspond to the `iss` claim in the provider's OpenID Connect ID
    /// tokens. Per the OIDC standard, path components are allowed but query
    /// parameters are not.
    /// Typically the URL consists of only a hostname, like
    /// `https://server.example.org` or `https://example.com`. The URL
    /// should not contain a port number.
    ///
    /// You cannot register the same provider multiple times in a single Amazon Web
    /// Services account. If you
    /// try to submit a URL that has already been used for an OpenID Connect
    /// provider in the
    /// Amazon Web Services account, you will get an error.
    url: []const u8,
};

pub const CreateOpenIDConnectProviderOutput = struct {
    /// The Amazon Resource Name (ARN) of the new IAM OpenID Connect provider that
    /// is
    /// created. For more information, see
    /// [OpenIDConnectProviderListEntry](https://docs.aws.amazon.com/IAM/latest/APIReference/API_OpenIDConnectProviderListEntry.html).
    open_id_connect_provider_arn: ?[]const u8 = null,

    /// A list of tags that are attached to the new IAM OIDC provider. The returned
    /// list of
    /// tags is sorted by tag key. For more information about tagging, see [Tagging
    /// IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    tags: ?[]const Tag = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOpenIDConnectProviderInput, options: CallOptions) !CreateOpenIDConnectProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOpenIDConnectProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateOpenIDConnectProvider&Version=2010-05-08");
    if (input.client_id_list) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ClientIDList.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
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
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
        }
    }
    if (input.thumbprint_list) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ThumbprintList.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    try body_buf.appendSlice(allocator, "&Url=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.url);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOpenIDConnectProviderOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateOpenIDConnectProviderResult")) break;
            },
            else => {},
        }
    }

    var result: CreateOpenIDConnectProviderOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OpenIDConnectProviderArn")) {
                    result.open_id_connect_provider_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try serde.deserializetagListType(allocator, &reader, "member");
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
