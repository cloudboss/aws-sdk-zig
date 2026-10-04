const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataProtectionSettings = @import("data_protection_settings.zig").DataProtectionSettings;

pub const GetDataProtectionSettingsInput = struct {
    /// The ARN of the data protection settings.
    data_protection_settings_arn: []const u8,

    pub const json_field_names = .{
        .data_protection_settings_arn = "dataProtectionSettingsArn",
    };
};

pub const GetDataProtectionSettingsOutput = struct {
    /// The data protection settings.
    data_protection_settings: ?DataProtectionSettings = null,

    pub const json_field_names = .{
        .data_protection_settings = "dataProtectionSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataProtectionSettingsInput, options: CallOptions) !GetDataProtectionSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces-web", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataProtectionSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces-web", "WorkSpaces Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/dataProtectionSettings/");
    try path_buf.appendSlice(allocator, input.data_protection_settings_arn);
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataProtectionSettingsOutput {
    const result: GetDataProtectionSettingsOutput = try aws.json.parseJsonObject(
        GetDataProtectionSettingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
