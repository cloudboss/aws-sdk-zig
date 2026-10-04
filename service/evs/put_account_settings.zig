const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountSetting = @import("account_setting.zig").AccountSetting;

pub const PutAccountSettingsInput = struct {
    /// A list of regional account-level EVS settings to create or update. Only the
    /// settings included in this list are modified.
    settings: []const AccountSetting,

    pub const json_field_names = .{
        .settings = "settings",
    };
};

pub const PutAccountSettingsOutput = struct {
    /// A list of regional account-level EVS settings, and their values, that were
    /// modified in this request.
    settings: ?[]const AccountSetting = null,

    pub const json_field_names = .{
        .settings = "settings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAccountSettingsInput, options: CallOptions) !PutAccountSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "evs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAccountSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("evs", "evs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonElasticVMwareService.PutAccountSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAccountSettingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutAccountSettingsOutput, body, allocator);
}
