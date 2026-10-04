const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RelayAuthentication = @import("relay_authentication.zig").RelayAuthentication;

pub const GetRelayInput = struct {
    /// A unique relay identifier.
    relay_id: []const u8,

    pub const json_field_names = .{
        .relay_id = "RelayId",
    };
};

pub const GetRelayOutput = struct {
    /// The authentication attribute—contains the secret ARN where the customer
    /// relay server credentials are stored.
    authentication: ?RelayAuthentication = null,

    /// The timestamp of when the relay was created.
    created_timestamp: ?i64 = null,

    /// The timestamp of when relay was last updated.
    last_modified_timestamp: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the relay.
    relay_arn: ?[]const u8 = null,

    /// The unique relay identifier.
    relay_id: []const u8,

    /// The unique name of the relay.
    relay_name: ?[]const u8 = null,

    /// The destination relay server address.
    server_name: ?[]const u8 = null,

    /// The destination relay server port.
    server_port: ?i32 = null,

    pub const json_field_names = .{
        .authentication = "Authentication",
        .created_timestamp = "CreatedTimestamp",
        .last_modified_timestamp = "LastModifiedTimestamp",
        .relay_arn = "RelayArn",
        .relay_id = "RelayId",
        .relay_name = "RelayName",
        .server_name = "ServerName",
        .server_port = "ServerPort",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRelayInput, options: CallOptions) !GetRelayOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRelayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mail-manager", "MailManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.GetRelay");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRelayOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetRelayOutput, body, allocator);
}
