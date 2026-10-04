const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const globalEndpointTokenVersion = @import("global_endpoint_token_version.zig").globalEndpointTokenVersion;

pub const SetSecurityTokenServicePreferencesInput = struct {
    /// The version of the global endpoint token. Version 1 tokens are valid only in
    /// Amazon Web Services Regions that are available by default. These tokens do
    /// not work in
    /// manually enabled Regions, such as Asia Pacific (Hong Kong). Version 2 tokens
    /// are valid
    /// in all Regions. However, version 2 tokens are longer and might affect
    /// systems where you
    /// temporarily store tokens.
    ///
    /// For information, see [Activating and
    /// deactivating STS in an Amazon Web Services
    /// Region](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html) in the
    /// *IAM User Guide*.
    global_endpoint_token_version: globalEndpointTokenVersion,
};

pub const SetSecurityTokenServicePreferencesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetSecurityTokenServicePreferencesInput, options: CallOptions) !SetSecurityTokenServicePreferencesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetSecurityTokenServicePreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetSecurityTokenServicePreferences&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&GlobalEndpointTokenVersion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.global_endpoint_token_version.wireName());

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetSecurityTokenServicePreferencesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetSecurityTokenServicePreferencesOutput = .{};

    return result;
}
