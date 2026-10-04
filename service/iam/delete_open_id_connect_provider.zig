const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteOpenIDConnectProviderInput = struct {
    /// The Amazon Resource Name (ARN) of the IAM OpenID Connect provider resource
    /// object to
    /// delete. You can get a list of OpenID Connect provider resource ARNs by using
    /// the
    /// [ListOpenIDConnectProviders](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListOpenIDConnectProviders.html) operation.
    open_id_connect_provider_arn: []const u8,
};

pub const DeleteOpenIDConnectProviderOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteOpenIDConnectProviderInput, options: CallOptions) !DeleteOpenIDConnectProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteOpenIDConnectProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteOpenIDConnectProvider&Version=2010-05-08");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteOpenIDConnectProviderOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: DeleteOpenIDConnectProviderOutput = .{};

    return result;
}
