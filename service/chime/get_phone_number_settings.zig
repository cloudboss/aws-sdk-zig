const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetPhoneNumberSettingsInput = struct {};

pub const GetPhoneNumberSettingsOutput = struct {
    /// The default outbound calling name for the account.
    calling_name: ?[]const u8 = null,

    /// The updated outbound calling name timestamp, in ISO 8601 format.
    calling_name_updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .calling_name = "CallingName",
        .calling_name_updated_timestamp = "CallingNameUpdatedTimestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPhoneNumberSettingsInput, options: CallOptions) !GetPhoneNumberSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPhoneNumberSettingsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("chime", "Chime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/settings/phone-number";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPhoneNumberSettingsOutput {
    const result: GetPhoneNumberSettingsOutput = try aws.json.parseJsonObject(
        GetPhoneNumberSettingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
