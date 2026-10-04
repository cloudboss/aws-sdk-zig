const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ByoipCidr = @import("byoip_cidr.zig").ByoipCidr;

pub const DeprovisionByoipCidrInput = struct {
    /// The address range, in CIDR notation. The prefix must be the same prefix that
    /// you specified
    /// when you provisioned the address range.
    ///
    /// For more information, see
    /// [Bring your own IP addresses
    /// (BYOIP)](https://docs.aws.amazon.com/global-accelerator/latest/dg/using-byoip.html) in
    /// the Global Accelerator Developer Guide.
    cidr: []const u8,

    pub const json_field_names = .{
        .cidr = "Cidr",
    };
};

pub const DeprovisionByoipCidrOutput = struct {
    /// Information about the address range.
    byoip_cidr: ?ByoipCidr = null,

    pub const json_field_names = .{
        .byoip_cidr = "ByoipCidr",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeprovisionByoipCidrInput, options: CallOptions) !DeprovisionByoipCidrOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeprovisionByoipCidrInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.DeprovisionByoipCidr");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeprovisionByoipCidrOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeprovisionByoipCidrOutput, body, allocator);
}
