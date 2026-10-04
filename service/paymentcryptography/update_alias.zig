const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Alias = @import("alias.zig").Alias;

pub const UpdateAliasInput = struct {
    /// The alias whose associated key is changing.
    alias_name: []const u8,

    /// The `KeyARN` for the key that you are updating or removing from the alias.
    key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias_name = "AliasName",
        .key_arn = "KeyArn",
    };
};

pub const UpdateAliasOutput = struct {
    /// The alias name.
    alias: ?Alias = null,

    pub const json_field_names = .{
        .alias = "Alias",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAliasInput, options: CallOptions) !UpdateAliasOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "payment-cryptography", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controlplane.payment-cryptography", "Payment Cryptography", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.UpdateAlias");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAliasOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateAliasOutput, body, allocator);
}
