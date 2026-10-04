const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const GetOpenIDConnectProviderInput = struct {
    /// The Amazon Resource Name (ARN) of the OIDC provider resource object in IAM
    /// to get
    /// information for. You can get a list of OIDC provider resource ARNs by using
    /// the
    /// [ListOpenIDConnectProviders](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListOpenIDConnectProviders.html) operation.
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    open_id_connect_provider_arn: []const u8,
};

pub const GetOpenIDConnectProviderOutput = struct {
    /// A list of client IDs (also known as audiences) that are associated with the
    /// specified
    /// IAM OIDC provider resource object. For more information, see
    /// [CreateOpenIDConnectProvider](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateOpenIDConnectProvider.html).
    client_id_list: ?[]const []const u8 = null,

    /// The date and time when the IAM OIDC provider resource object was created in
    /// the
    /// Amazon Web Services account.
    create_date: ?i64 = null,

    /// A list of tags that are attached to the specified IAM OIDC provider. The
    /// returned list of tags is sorted by tag key.
    /// For more information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    tags: ?[]const Tag = null,

    /// A list of certificate thumbprints that are associated with the specified IAM
    /// OIDC
    /// provider resource object. For more information, see
    /// [CreateOpenIDConnectProvider](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateOpenIDConnectProvider.html).
    thumbprint_list: ?[]const []const u8 = null,

    /// The URL that the IAM OIDC provider resource object is associated with. For
    /// more
    /// information, see
    /// [CreateOpenIDConnectProvider](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateOpenIDConnectProvider.html).
    url: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOpenIDConnectProviderInput, options: CallOptions) !GetOpenIDConnectProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOpenIDConnectProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetOpenIDConnectProvider&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&OpenIDConnectProviderArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.open_id_connect_provider_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOpenIDConnectProviderOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetOpenIDConnectProviderResult")) break;
            },
            else => {},
        }
    }

    var result: GetOpenIDConnectProviderOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClientIDList")) {
                    result.client_id_list = try serde.deserializeclientIDListType(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try serde.deserializetagListType(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ThumbprintList")) {
                    result.thumbprint_list = try serde.deserializethumbprintListType(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Url")) {
                    result.url = try allocator.dupe(u8, try reader.readElementText());
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
