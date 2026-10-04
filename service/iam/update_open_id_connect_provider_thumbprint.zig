const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const UpdateOpenIDConnectProviderThumbprintInput = struct {
    /// The Amazon Resource Name (ARN) of the IAM OIDC provider resource object for
    /// which
    /// you want to update the thumbprint. You can get a list of OIDC provider ARNs
    /// by using the
    /// [ListOpenIDConnectProviders](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListOpenIDConnectProviders.html) operation.
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    open_id_connect_provider_arn: []const u8,

    /// A list of certificate thumbprints that are associated with the specified IAM
    /// OpenID
    /// Connect provider. For more information, see
    /// [CreateOpenIDConnectProvider](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateOpenIDConnectProvider.html).
    thumbprint_list: []const []const u8,
};

pub const UpdateOpenIDConnectProviderThumbprintOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateOpenIDConnectProviderThumbprintInput, options: CallOptions) !UpdateOpenIDConnectProviderThumbprintOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOpenIDConnectProviderThumbprintInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UpdateOpenIDConnectProviderThumbprint&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&OpenIDConnectProviderArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.open_id_connect_provider_arn);
    for (input.thumbprint_list, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ThumbprintList.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateOpenIDConnectProviderThumbprintOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: UpdateOpenIDConnectProviderThumbprintOutput = .{};

    return result;
}
