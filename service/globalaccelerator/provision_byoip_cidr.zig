const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CidrAuthorizationContext = @import("cidr_authorization_context.zig").CidrAuthorizationContext;
const ByoipCidr = @import("byoip_cidr.zig").ByoipCidr;

pub const ProvisionByoipCidrInput = struct {
    /// The public IPv4 address range, in CIDR notation. The most specific IP prefix
    /// that you can
    /// specify is /24. The address range cannot overlap with another address range
    /// that you've brought
    /// to this Amazon Web Services Region or another Region.
    ///
    /// For more information, see
    /// [Bring your own IP addresses
    /// (BYOIP)](https://docs.aws.amazon.com/global-accelerator/latest/dg/using-byoip.html) in
    /// the Global Accelerator Developer Guide.
    cidr: []const u8,

    /// A signed document that proves that you are authorized to bring the specified
    /// IP address range to
    /// Amazon using BYOIP.
    cidr_authorization_context: CidrAuthorizationContext,

    pub const json_field_names = .{
        .cidr = "Cidr",
        .cidr_authorization_context = "CidrAuthorizationContext",
    };
};

pub const ProvisionByoipCidrOutput = struct {
    /// Information about the address range.
    byoip_cidr: ?ByoipCidr = null,

    pub const json_field_names = .{
        .byoip_cidr = "ByoipCidr",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ProvisionByoipCidrInput, options: CallOptions) !ProvisionByoipCidrOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "globalaccelerator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ProvisionByoipCidrInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("globalaccelerator", "Global Accelerator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.ProvisionByoipCidr");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ProvisionByoipCidrOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ProvisionByoipCidrOutput, body, allocator);
}
