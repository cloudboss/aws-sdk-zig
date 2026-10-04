const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountQuotas = @import("account_quotas.zig").AccountQuotas;
const AccountUsage = @import("account_usage.zig").AccountUsage;

pub const GetWebAccountSettingsInput = struct {
};

pub const GetWebAccountSettingsOutput = struct {
    /// The quotas that apply to web functions in your account in the current AWS
    /// Region.
    account_quotas: ?AccountQuotas = null,

    /// The current web function usage for your account in the current AWS Region.
    account_usage: ?AccountUsage = null,

    pub const json_field_names = .{
        .account_quotas = "accountQuotas",
        .account_usage = "accountUsage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWebAccountSettingsInput, options: CallOptions) !GetWebAccountSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWebAccountSettingsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("lambda", "Lambda Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2025-03-07/web-account-settings";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWebAccountSettingsOutput {
    const result: GetWebAccountSettingsOutput = try aws.json.parseJsonObject(
        GetWebAccountSettingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
